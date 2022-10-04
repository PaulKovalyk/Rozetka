class Product < ApplicationRecord
    enum :status, {
    out_of_stock: 'out_of_stock',
    in_stock: 'in_stock',
    running_low:  'running_low'
    }, default: 'in_stock'
end
