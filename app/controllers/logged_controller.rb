class LoggedController < ApplicationController
    before_action :logged?, only: [:index]

    def logged?
        raise NotAuthenticated unless session[:id]
    end
end