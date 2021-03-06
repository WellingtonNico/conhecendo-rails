# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # O nome do email só funciona se for posto na configuração no formato:
  # "<nome desejado> <<email de origem>>", mantendo as setas "<>" no email
  default from: "Bookstore <#{ENV['MAIL_USER']}>"

  def created(order)
    @order = order
    mail to: @order.person.email, subject: "Pedido #{@order.id} recebido com sucesso!"
  end

end
