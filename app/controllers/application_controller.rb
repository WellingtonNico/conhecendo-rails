class ApplicationController < ActionController::Base
    NotAuthenticated = Class.new(StandardError)

    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    rescue_from NotAuthenticated, with: :not_authenticated

    def not_authenticated
        flash[:notice] = 'Você precisa estar autenticado'
        redirect_to new_session_url
    end

    def record_not_found
        flash[:notice] = 'Registro não encontrado'
        redirect_to action: 'index'
    end
end
