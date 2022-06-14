require "application_system_test_case"

class UserTest < ApplicationSystemTestCase
    setup do
        @person = people(:admin)
        @good_password = 'testetamanhobom'
        @bad_password = 'nananinanao'
        @bad_email = 'foo@bar.com'
    end

    test "não pode fazer login" do``
        visit new_session_url
        assert_selector 'h1', text: 'Login'
        fill_in 'Email', with: @person.email
        fill_in 'Password', with: @bad_password
        click_button 'login'
        assert_selector 'p#notice', text: "Olá, #{@person.name}!"
    end


end
