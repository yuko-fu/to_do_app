class User < ApplicationRecord
  has_many :tasks
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, length: { minimum: 6 }
  before_validation { email.downcase! }
  before_destroy :check_last_admin_user
  
  private

  def checkout_last_admin_user
    if self.admin && User.where(admin: true).count == 1
      errors.add(:base, "最後の管理ユーザーを削除することはできません")
      throw :abort
    end
  end
end
