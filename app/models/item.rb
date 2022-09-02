class Item < ApplicationRecord
  validates_presence_of :name
  validates_presence_of :description
  validates :unit_price, presence: true, numericality: true

  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices

  def self.find_all_by_name(name)
    where('lower(name) like ?', "%#{name.downcase}%")
  end

  def self.find_by_name(name)
    where('lower(name) like ?', "%#{name.downcase}%").first
  end

end
