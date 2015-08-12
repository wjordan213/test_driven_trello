module Api
  class ApiController < ApplicationController
    before_action :require_logged_in

    private

    def require_logged_in
      unless logged_in?
        redirect_to new_session_url
      end
    end
  end
end
