class User < ApplicationRecord
  # FacebookとGoogleのOumniAuthを使用
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  has_many :sns_credentials

  # omniauth_callbacks_controller.rbに記述した、User.from_omniauthを呼び出し
  def self.from_omniauth(auth)
    # 保存するレコードがDBに存在するか検索を行い、検索した条件のレコードがあればそのレコードを返し、なければインスタンスを保存するメソッド（保存時にUserモデルとSnsCredentialモデルを紐付け）
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email
    )
  end
end
