class Order < ApplicationRecord
  belongs_to :person
  has_many :order_items
  validates :person, presence: true

  def total
    order_items.reduce(0) do |memo, item|
      memo += item.quantity * item.value
      memo
    end
  end

  def self.create_by_cart(person_id,items)
    Book.transaction do
      order = Order.new(person_id:person_id)
      items.each do |item|
        item[:item].sell(item[:qty])
        order_item = OrderItem.new
        order_item.book = item[:item]
        order_item.quantity = item[:qty]
        order_item.value = item[:item].value
        order.order_items << order_item
      end
      order.save!
      order
    end
  rescue Exception => e
    logger.error "erro salvando o pedido: #{e}"
    nil
  end

end
