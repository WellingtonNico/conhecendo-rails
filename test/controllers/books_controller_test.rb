require 'test_helper'

class BooksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @good_password = 'testetamanhobom'
    @person = people(:admin)
    @book = books(:one)
  end

  def login
    sign_in(@person.email, @good_password)
  end

  test "should get index" do
    login
    get books_url
    assert_response :success
  end

  test "should get new" do
    login
    get new_book_url
    assert_response :success
  end

  test "should create book" do
    login
    assert_difference('Book.count') do
      post books_url, params: { book: { person_id: @book.person_id, published_at: @book.published_at, text: @book.text, title: @book.title, value: @book.value } }
    end

    assert_redirected_to book_url(Book.last)
  end

  test "should show book" do
    login
    get book_url(@book)
    assert_response :success
  end

  test "should get edit" do
    login
    get edit_book_url(@book)
    assert_response :success
  end

  test "should update book" do
    login
    patch book_url(@book), params: { book: { person_id: @book.person_id, published_at: @book.published_at, text: @book.text, title: @book.title, value: @book.value } }
    assert_redirected_to book_url(@book)
  end

  test "should destroy book" do
    login
    assert_difference('Book.count', -1) do
      delete book_url(@book)
    end

    assert_redirected_to books_url
  end
end
