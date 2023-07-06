class User < ApplicationRecord
  has_many :tasks, dependent: :destroy
  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  has_secure_password
  validates :password, length: { minimum: 6 }
  before_validation { email.downcase! }
  before_destroy :last_admin_user
  before_update :update_admin_user
  # enum role: { user: 0, admin: 1 }
  private

  def last_admin_user
    if self.admin && User.where(admin: true).count == 1
      errors.add(:base, "最後の管理ユーザーを削除できません")
      throw :abort
    end
  end

  def update_admin_user
    if self.admin && User.where(admin: true).count == 1
      errors.add(:base, "最後の管理ユーザーは更新できません")
      throw :abort
    end
  end
end
