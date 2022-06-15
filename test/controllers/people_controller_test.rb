require 'test_helper'

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @person = people(:admin)
    @good_password = 'testetamanhobom'
    @bad_password = 'nananinanao'
    @good_email = 'funcional@teste.com'
    @good_new_admin_person = { admin: true, born_at: @person.born_at, email: @good_email, name: @person.name, password: @good_password, password_confirmation: @good_password }
  end
  
  def login
    sign_in(@person.email, @good_password)
  end

  test "should get index" do
    login
    get people_url
    assert_response :success
  end

  test "should get new" do
    login
    get new_person_url
    assert_response :success
  end

  test "should create person" do
    login
    assert_difference('Person.count') do
      post people_url, params: { person: { admin: @person.admin, born_at: @person.born_at, email: @good_email, name: 'Zaratustra', password: @good_password,  password_confirmation: @good_password } }
    end

    assert_redirected_to person_url(Person.where(email: @good_email).first)
  end

  test "should show person" do
    login
    get person_url(@person)
    assert_response :success
  end

  test "should get edit" do
    login
    get edit_person_url(@person)
    assert_response :success
  end

  test "deve atualizar a pessoa sem alterar a senha" do
    login
    old_password = @person.password_digest
    patch person_url(@person), params: { person: { admin: @person.admin, born_at: @person.born_at, email: @person.email, name: @person.name } }
    assert_redirected_to person_url(@person)
    @person.reload
    assert_equal old_password,@person.password_digest
  end

  test "deve atualizar a pessoa alterando a senha" do
    login
    old_password = @person.password_digest
    patch person_url(@person), params: { person: { admin: @person.admin, born_at: @person.born_at, email: @person.email, name: @person.name, password: @good_password, password_confirmation: @good_password } }
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
    login
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

  test "deve ter um escopo para retornar administradores" do
    login
    assert_respond_to Person, :admins
    assert_equal 1, Person.admins.size
  end
  
  test "deve ter um escopo para retornar usuarios por dominio" do
    login
    assert_respond_to Person, :by_domain
    assert_equal 1, Person.by_domain("gmail.com").size
  end

  test "deve ter um escopo padrão para retornar os usuários em ordem alfabética" do
    people = Person.all
    assert people.first.name < people.last.name, "#{people.last.name} deveria estar antes de #{people.first.name}"
  end

  test "deve haver uma rota para obter os administradores" do
    login
    get admins_people_url
    assert_response :success
    assert_select 'table' do
      assert_select 'tbody' do
        assert_select 'tr',1
      end
    end
  end

  test "deve haver uma url onde constam mudanças no model" do
    assert_routing({path: "/people/#{@person.id}/changed"},{controller:"people",action: 'changed',id: @person.id.to_param})
  end

  test "deve mostrar informação sobre quando a pessoa foi alterada" do
    login
    get changed_person_url(@person.id)
    assert_response :success
    assert_select 'p#name', text: "Nome: #{@person.name}"
    assert_select 'p#created', text: "Criado em: #{I18n.localize(@person.created_at)}"
    assert_select 'p#updated', text: "Alterado em: #{I18n.localize(@person.updated_at)}"
  end

  test "deve redirecionar para a tela de login" do
    get people_url
    assert_redirected_to new_session_url
  end

  test "não deve mostrar o campo admin no formulário" do
    login
    get edit_person_url(@person)
    assert_response :success
    assert_select "input[name='person[admin]']",0
  end

  test "não deve permitir alterar a flag de admin" do
    login
    assert_difference('Person.count') do
      post people_url, params: {person: @good_new_admin_person}
    end
    assert !Person.where(email: @good_email).take.admin?
  end

  test "deve mostrar elementos se o usuário corrente for admin" do
    assert @person.update_attribute(:admin, true)
    login
    get edit_person_url(@person)
    assert_response :success
    assert_select "input[type=checkbox][name=admin]",1
  end    

  test "não deve mostrar elementos se o usuário corrente não for admin" do
    assert @person.update_attribute(:admin, false)
    login
    get edit_person_url(@person)
    assert_response :success
    assert_select "input[type=checkbox][name='admin']",0
  end    

  test "deve permitir criar pessoa com a flag de admin se o usuário corrente for admin" do 
    assert @person.update_attributes(admin: true)
    login
    assert_difference('Person.count') do
      post people_url, params: {person: @good_new_admin_person,admin: true}
    end
    assert Person.where(email: @good_email).take.admin?
  end

  test "não deve permitir cirar pessoa com a flag de admin se o usuário corrente não for admin" do 
    assert @person.update_attributes(admin: false)
    sign_in(@person.email, @good_password)
    assert_difference('Person.count') do
      post people_url, params:  {person: @good_new_admin_person,admin: true}
    end
    assert !Person.where(email: @good_email).take.admin?
  end

  test "deve permitir alterar a flag de admin para true se o usuário corrente for admin" do
    assert @person.update_attribute(:admin, true)
    login
    regular = people(:autor)
    assert !regular.admin?
    put person_url(regular), params: {admin: true, person: regular.attributes }
    regular.reload
    assert regular.admin?
  end

  test "deve permitir alterar a flag de admin para false do usuário corrente se o mesmo for admin" do
    assert @person.update_attribute(:admin, true)
    login
    put person_url(@person), params: {admin: false, person: @person.attributes }
    @person.reload
    assert !@person.admin?
  end

  test "não deve permitir alterar a flag de admin para false do usuário corrente se o mesmo não for admin" do
    assert @person.update_attribute(:admin, false)
    login
    put person_url(@person), params: {admin: true, person: @person.attributes }
    @person.reload
    assert !@person.admin?
  end
    
end
