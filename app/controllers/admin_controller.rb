class AdminController < LoggedController
    before_action :admin?

    private

    def admin?
        raise NotAdmin unless session[:admin]
    end
end
