class Order < ApplicationRecord
  has_many :line_items, dependent: :destroy

  enum :pay_type, {
    check: 0,
    credit_card: 1,
    purchase_order: 2
  }

  validates :name, :address, :email, presence: true
  validates :pay_type, inclusion: pay_types.keys


  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil

      # como tenho has_many :line_items definido, Isso faz com que cada Order tenha um método de instância chamado line_items.
      line_items << item #aqui to dando um push no item
    end
  end
end
