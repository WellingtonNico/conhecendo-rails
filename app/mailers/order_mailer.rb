class OrderMailer < ApplicationMailer

  def created(order)
    @order = order
    mail to: @order.person.email, subject: "Pedido #{@order.id} recebido com sucesso!", from: ['Bookstore']
  end
end
