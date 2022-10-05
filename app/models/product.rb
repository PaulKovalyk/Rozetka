class Product < ApplicationRecord
    enum :status, {
    'Out of stock': 'out_of_stock',
    'In stock': 'in_stock',
    'Running low':  'running_low'
    }, default: 'in_stock'
    belongs_to :category
end
