class InvoiceItem < ApplicationRecord

  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true

  belongs_to :item
  belongs_to :invoice
  has_one :merchant, through: :item

end
