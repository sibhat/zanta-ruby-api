# frozen_string_literal: true

module Api
  module V1
    class CustomersController < ApplicationController
      before_action :set_customer, only: %i[show update destroy]

      # GET /customers
      def index
        @customers = Customer.all

        render json: @customers
      end

      # GET /customers/1
      def show
        render json: @customer
      end

      # POST /customers
      # @return [Object]
      # def create
      #   user = User.new(customer_params)
      #   if user.save
      #     customer = Customer.new(user_id: user.id)
      #     self.resource = warden.set_user(user, scope: :user)
      #     sign_in(resource_name, resource)
      #
      #     if customer.save
      #       render json: customer, status: :created
      #     else
      #       render json: customer.errors, status: :unprocessable_entity
      #     end
      #   else
      #     render json: user.errors, status: :unprocessable_entity
      #   end
      # end

      # PATCH/PUT /customers/1
      def update
        if @customer.update(customer_params)
          render json: @customer
        else
          render json: @customer.errors, status: :unprocessable_entity
        end
      end

      # DELETE /customers/1
      def destroy
        @customer.destroy
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_customer
        @customer = Customer.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def customer_params
        params.require(:customer).permit(:name, :email, :password)
      end
    end
  end
end