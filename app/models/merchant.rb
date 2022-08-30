class Merchant < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :status
  enum status: {"disabled": 0, "enabled": 1}

  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  has_many :customers, through: :invoices

end
