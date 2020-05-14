class User < ApplicationRecord
  before_validation {email.downcase!}
  before_destroy :destroy_ensure_admin
  before_update :update_ensure_admin

  validates :name, presence: true, length: {maximum: 30}
  validates :email, presence: true, length: {maximum: 90}, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
  validates :password, presence: true, length: {minimum: 6}
  has_secure_password

  has_many :tasks, dependent: :delete_all

  private
  def update_ensure_admin
    throw(:abort) if self.admin == false && User.where(admin: true).count == 1
  end
  def destroy_ensure_admin
    throw(:abort) if self.admin == true && User.where(admin: true).count == 1
  end
end
