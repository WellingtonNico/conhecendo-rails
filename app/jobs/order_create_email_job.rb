class OrderCreateEmailJob < ApplicationJob
  queue_as :default

  def perform(order)
    OrderMailer.created(order).deliver_later
  end
end
