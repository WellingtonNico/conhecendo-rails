class LoggedController < ApplicationController
    before_action :logged?

    def logged?
        raise NotAuthenticated unless session[:id]
    end
end