class OrderCreateEmailJob < ApplicationJob
  queue_as :default

  def perform(id)
    OrderMailer.created(id).deliver_now
  end
end
