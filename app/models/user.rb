class User < ApplicationRecord
  # FacebookとGoogleのOumniAuthを使用
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :sns_credentials
end
