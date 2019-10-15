# frozen_string_literal: true

require 'google/apis/plus_v1'
require 'signet/oauth_2/client'

class Users::TokenController < DeviseController
  prepend_before_action :require_no_authentication, only: [:new, :create]
  prepend_before_action :allow_params_authentication!, only: :create
  prepend_before_action :verify_signed_out_user, only: :destroy
  prepend_before_action(only: [:create, :destroy]) { request.env["devise.skip_timeout"] = true }

  def create
    info = user_info.get_person('me')
    user = User.from_google(info)

    self.resource = warden.set_user(user, scope: :user)
    sign_in(resource_name, resource)
    render json: payload(user), status: :ok
  end

  # @return [Object]
  def create_customer
    user = User.new(customer_params)
    if user.save
      customer = Customer.new(user_id: user.id)
      self.resource = warden.set_user(user, scope: :user)
      sign_in(resource_name, resource)

      if customer.save
        render json: customer, status: :created
      else
        render json: customer.errors, status: :unprocessable_entity
      end
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  # @return [Object]
  def create_business
    user = User.new(create_business_user_params)
    if user.save
      business = Business.new(user_id: user.id, **create_business_params)

      self.resource = warden.set_user(user, scope: :user)
      sign_in(resource_name, resource)

      if business.save
        render json: business, status: :created
      else
        render json: business.errors, status: :unprocessable_entity
      end
    else
      render json: user.errors, status: :unprocessable_entity
    end
  end

  private

  def payload(user)
    { user: user }
  end

  def user_info
    Google::Apis::PlusV1::PlusService.new.tap do |userinfo|
      userinfo.key = ENV['GOOGLE_KEY']
      userinfo.authorization = auth_client
    end
  end

  def auth_client
    Signet::OAuth2::Client.new(
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://www.googleapis.com/oauth2/v3/token',
      client_id: ENV['GOOGLE_CLIENT_ID'], client_secret: ENV['GOOGLE_SECRET'],
      scope: 'email profile',
      redirect_uri: "http://localhost:3000",
      access_type: 'offline'
    ).tap do |client|
      client.code = params['code']
      client.fetch_access_token!
    end
  end

  def sign_in_params
    devise_parameter_sanitizer.sanitize(:sign_in)
  end

  def serialize_options(resource)
    methods = resource_class.authentication_keys.dup
    methods = methods.keys if methods.is_a?(Hash)
    methods << :password if resource.respond_to?(:password)
    { methods: methods, only: [:password] }
  end

  def auth_options
    { scope: resource_name, recall: "#{controller_path}#new" }
  end

  def translation_scope
    'devise.sessions'
  end

  private

  # Only allow a trusted parameter "white list" through.
  def customer_params
    params.require(:customer).permit(:name, :email, :password)
  end

  # Only allow a trusted parameter "white list" through.
  def create_business_params
    params.require(:business).permit(:business_name, :location)
  end

  def create_business_user_params
    params.require(:business).permit(:email, :password)
  end

  # Check if there is no signed in user before doing the sign out.
  #
  # If there is no signed in user, it will set the flash message and redirect
  # to the after_sign_out path.
  def verify_signed_out_user
    if all_signed_out?
      set_flash_message! :notice, :already_signed_out

      respond_to_on_destroy
    end
  end

  def all_signed_out?
    users = Devise.mappings.keys.map { |s| warden.user(scope: s, run_callbacks: false) }

    users.all?(&:blank?)
  end

  def respond_to_on_destroy
    # We actually need to hardcode this as Rails default responder doesn't
    # support returning empty response on GET request
    respond_to do |format|
      format.all { head :no_content }
      format.any(*navigational_formats) { redirect_to after_sign_out_path_for(resource_name) }
    end
  end
end
