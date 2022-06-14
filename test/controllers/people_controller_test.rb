require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:admin)
    @good_password = 'testetamanhobom'
    @bad_password = 'nananinanao'
  end

  test "should get index" do
    get people_url
    assert_response :success
  end

  test "should get new" do
    get new_person_url
    assert_response :success
  end

  test "should create person" do
    assert_difference('Person.count') do
      post people_url, params: { person: { admin: @person.admin, born_at: @person.born_at, email: 'funcional@teste.com', name: @person.name, password: @good_password } }
    end

    assert_redirected_to person_url(Person.last)
  end

  test "should show person" do
    get person_url(@person)
    assert_response :success
  end

  test "should get edit" do
    get edit_person_url(@person)
    assert_response :success
  end

  test "should update person" do
    patch person_url(@person), params: { person: { admin: @person.admin, born_at: @person.born_at, email: @person.email, name: @person.name, password: @good_password, password_confirmation: @good_password} }
    assert_redirected_to person_url(@person)
  end

  test "deve atualizar a pessoa sem alterar a senha" do
    old_password = @person.password_digest
    patch person_url(@person), params: { person: { admin: @person.admin, born_at: @person.born_at, email: @person.email, name: @person.name } }
    assert_redirected_to person_url(@person)
    @person.reload
    assert_equal old_password,@person.password_digest
  end

  test "deve atualizar a pessoa alterando a senha" do
    old_password = @person.password_digest
    patch person_url(@person), params: { person: { admin: @person.admin, born_at: @person.born_at, email: @person.email, name: @person.name, password: @good_password } }
    assert_redirected_to person_url(@person)
    @person.reload
    assert_not_equal old_password,@person.password_digest
  end

  test "deve autenticar a pessoa" do
    assert @person.authenticate(@good_password)
  end

  test "não deve autenticar a pessoa" do
    assert !@person.authenticate(@bad_password)
  end

  test "should destroy person" do
    assert_difference('Person.count', -1) do
      delete person_url(@person)
    end
    assert_redirected_to people_url
  end

  test "deve ter um método para autenticar a pessoa através de email e senha" do
    assert_respond_to Person, :auth
  end

  test "deve autenticar com email e senha" do
    assert_not_nil Person.auth(@person.email,@good_password)
  end

  test "não deve autenticar com email e senha" do
    assert_nil Person.auth(@person.email,@bad_password)
  end

  

end
