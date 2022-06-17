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
end
