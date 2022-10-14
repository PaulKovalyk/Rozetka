# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  enum role: { user: 0, admin: 1 }
  after_initialize :set_default_role, if: :new_record?
  has_one :cart
  has_many :orders
  validates :first_name, presence: true, length: { minimum: 1, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 30 }
  validates :email, presence: true, uniqueness: true, length: { minimum: 3, maximum: 40 }

  accepts_nested_attributes_for :orders
  def set_default_role
    self.role ||= :user
  end
end
