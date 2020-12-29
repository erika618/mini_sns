class User < ApplicationRecord
  # FacebookとGoogleのOumniAuthを使用
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  has_many :sns_credentials

  # omniauth_callbacks_controller.rbに記述した、User.from_omniauthを呼び出し
  def self.from_omniauth(auth)
    # 保存するレコードがDBに存在するか検索。検索した条件のレコードがあればそのレコードを返し、なければインスタンスを保存する
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
    # sns認証したことがあればアソシエーションで取得
    # 無ければemailでユーザー検索して取得orビルド(保存はしない)
    user = User.where(email: auth.info.email).first_or_initialize(
      nickname: auth.info.name,
      email: auth.info.email
    )
    # userが登録済みであるか判断
    if user.persisted?
      # ログインの際に、sns.userを更新して紐付けを行う
      sns.user = user
      sns.save
    end
    # snsに入っているsns_uidをビューで扱えるようにするため、コントローラーに渡す
    { user: user, sns: sns }
  end
end
