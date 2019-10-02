class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :jwt_authenticatable, jwt_revocation_strategy: self

  def self.from_google(google_info)
    email = google_info.emails.first.value
    user = User.where(email: email).first

    # Uncomment the section below if you want users to be created if they don't exist
    unless user
      user = User.create(
        name: google_info.display_name,
        email: email,
        password: Devise.friendly_token[0, 20]
      )
    end
    user
  end
end
