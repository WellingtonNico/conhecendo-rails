class PubController < ApplicationController
  def index
    @books = Book.all
  end

  def book
    @book = Book.find(params[:id])
  end

  def author
    @author = Person.find(params[:id])
  end

  def sobre
  end

  def find_cart
    session[:cart] ||= Cart.new
  end

  def buy
    find_cart << Book.find(params[:id])
    redirect_to action: :cart
  end

  def cart
    @cart = find_cart
  end

  def remove_cart_item
    @book = Book.find(params[:id])
    @cart = find_cart
    @cart - @book
    # é possível deixar o redirecionamento de fora, pois foi usado na view o 
    # atributo remote:true da tag link_to, que permite que a acão seja executada
    # sem que precise de um redirecionamento
    # redirect_to cart_path
  end


end
