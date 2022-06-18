# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/created
  def created(order)
    @order = order
    mail to: @order.person.email, subject: "Pedido #{@order.id} recebido com sucesso!", from: ['Bookstore']
  end

end
