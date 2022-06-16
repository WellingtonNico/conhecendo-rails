require 'test_helper'

class BookTest < ActiveSupport::TestCase
  setup do
    @book = books(:one)
    @person = people(:admin)
  end

  test "deve ter um título" do 
    @book.title = nil
    assert !@book.valid?
  end
  
  test "o título não pode ter mais de 100 caracteres" do
    @book.title = '*' * 101
    assert !@book.valid?
  end 
  
  test "deve ter uma data de publicação" do
    @book.published_at = nil
    assert !@book.valid?
  end

  test "deve ter um texto" do
    @book.text = nil
    assert !@book.valid?
  end

  test "deve ter um valor maior do que o permitido" do
    @book.value = 100000000.00
    assert !@book.valid?
  end

  test "a pessoa deve ter uma coleção de livros" do
    assert_respond_to @person, :books
    assert_kind_of Book,@person.books.first
  end
  
  test "deve ser associado a uma pessoa" do
    @book.person = nil
    assert !@book.valid?
  end

  test "deve apagar os livros quando apagar a pessoa" do
    person = people(:admin)
    assert person.books.size > 0
    assert_difference('Person.count', -1) do
      assert_difference('Book.count',person.books.size * -1) do
        assert person.destroy, "deveria apagar a pessoa"
      end
    end 
  end


end
