class SnsCredential < ApplicationRecord
  belongs_to :user
end

class SnsCredential < ApplicationRecord
  # 取得したFacebook（またはGoogle）の情報を、外部キーが無くても保存できるオプションを付与
  belongs_to :user, optional: true
end
