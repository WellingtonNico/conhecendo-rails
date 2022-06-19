class OrderCreateEmailJob < ApplicationJob
  queue_as :default

  def perform(id)
    OrderMailer.created(id).deliver_now
    OrdersChannel.broadcast_to(Order.find(id),msg: 'E-mail de confirmação enviado!')
  end
end
