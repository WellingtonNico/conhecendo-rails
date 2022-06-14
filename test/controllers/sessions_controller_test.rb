require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
    setup do
        @person = people(:admin)
        @good_password = 'testetamanhobom'
        @bad_password = 'nananinanao'
        @bad_email = 'foo@bar.com'
    end

    test "deve ter um formulário de login" do
        get new_session_url
        assert_response :success
        assert_select 'form[action=?]', sessions_path do
            # usa se aspas no nome, pois é procurada uma string
            assert_select 'input[type=text][name=\'email\']'
            assert_select 'input[type=password][name=\'password\']'
            assert_select 'input[type=submit]'
        end
    end

    test "não deve fazer login com a senha errada" do
        post sessions_url, params: { email: @person.email, password: @bad_password }
        assert_nil session[:id]
        assert_redirected_to new_session_url
    end

    test "deve fazer o login" do
        post sessions_url, params: { email: @person.email, password: @good_password }
        assert_equal @person.id, session[:id]
        assert_equal @person.name, session[:name]
        assert_equal @person.admin, session[:admin]
        assert_equal "Olá, #{@person.name}!",flash[:notice]
        assert_redirected_to people_path
    end
        
    test "deve fazer logout" do
        delete session_url(@person)
        assert_nil session[:id]
        assert_nil session[:name]
        assert_nil session[:admin]
        assert_redirected_to new_session_url
    end

    test "deve haver uma url de login" do
        assert_recognizes({controller: 'sessions',action: 'new'},{path: 'login'})
    end

    test "deve haver uma url de logout" do
        assert_recognizes({controller: 'sessions',action: 'destroy'},{path: 'logout',method:'delete'})
    end

end