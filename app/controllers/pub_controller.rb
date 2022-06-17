class PubController < ApplicationController
  def index
    @books = Book.all
  end

  def sobre
  end
end
