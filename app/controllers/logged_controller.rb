class LoggedController < ApplicationController
    NotAuthenticated = Class.new(StandardError)
    rescue_from NotAuthenticated, with: :not_authenticated

    before_action :logged?

    def logged?
        raise NotAuthenticated unless session[:id]
    end
end