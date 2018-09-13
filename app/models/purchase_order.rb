class PurchaseOrder < ApplicationRecord
  belongs_to :line_item
  belongs_to :store
end
