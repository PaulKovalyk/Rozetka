# frozen_string_literal: true

class Order < ApplicationRecord
  has_and_belongs_to_many :products
  belongs_to :user, optional: true
  validates :phone, presence: true
end
