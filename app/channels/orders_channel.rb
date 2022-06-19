class OrdersChannel < ApplicationCable::Channel
  def subscribed
    Rails.logger.info "INSCRIÇÃO FEITA NO CANAL DE ORDERS, order #{params[:id]}"
    stream_for Order.find(params[:id])
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
