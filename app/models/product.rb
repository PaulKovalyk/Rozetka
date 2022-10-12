# frozen_string_literal: true

class Product < ApplicationRecord
  enum :status, {
    'Out of stock': 'out_of_stock',
    'In stock': 'in_stock',
    'Running low': 'running_low'
  }, default: 'in_stock'
  belongs_to :category
  has_and_belongs_to_many :order
  has_and_belongs_to_many :carts
  validates :title, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
end
