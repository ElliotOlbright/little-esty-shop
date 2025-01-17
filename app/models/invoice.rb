class Invoice < ApplicationRecord
  enum status: { cancelled: 0, 'in progress' => 1, completed: 2 }

  belongs_to :customer
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items 
  has_many :discounts, through: :merchants

  validates :status, presence: true, inclusion: { in: Invoice.statuses.keys }

  def invoice_revenue
    invoice_items.sum("invoice_items.unit_price * invoice_items.quantity")
  end

  def after_discount
    total = invoice_items.sum do |ii|
      ii.discount_revenue
    end
    total
  end
end
