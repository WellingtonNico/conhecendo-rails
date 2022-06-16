require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  setup do
    @book = books(:one)
    @person = people(:admin)
  end

  # categorias
  test 'deve ter categorias' do
    assert_respond_to @book, :categories
  end

  test 'deve ter categorias do tipo correto' do
    @book.categories << categories(:tech)
    assert_kind_of Category, @book.categories.first
  end
end
