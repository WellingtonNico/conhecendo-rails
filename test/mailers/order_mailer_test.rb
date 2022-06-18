require 'test_helper'

class OrderMailerTest < ActionMailer::TestCase
  setup do
    @person = people(:admin)
    @order = orders(:one)
    @appEmail = 'robo.camillo.parts@gmail.com'
    @mail = OrderMailer.created(@order)
  end

  test "created" do
    assert_equal "Pedido #{@order.id} recebido com sucesso!", @mail.subject
    assert_equal [@order.person.email], @mail.to
    assert_equal ['Bookstore'], @mail.from
  end

  test "deliver_now" do
    assert @mail.deliver_now
  end

end
