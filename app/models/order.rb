# frozen_string_literal: true

class Order < ApplicationRecord
  has_and_belongs_to_many :products
  belongs_to :user, optional: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :first_name, presence: true, length: { minimum: 1, maximum: 30 }
  validates :last_name, presence: true, length: { minimum: 1, maximum: 30 }
end
