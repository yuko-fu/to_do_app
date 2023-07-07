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


  private

  def admin_cannot_update
    throw :abort if User.exists?(admin: true).count == 1 && self.saved_change_to_admin == [true, false]
    errors.add(:base, "最後の管理ユーザーを編集できません")
  end
  
  def admin_cannot_delete
    throw :abort if User.exists?(admin: true).count == 1 && self.admin == true
    errors.add(:base, "最後の管理ユーザーを削除できません")
  end
end
