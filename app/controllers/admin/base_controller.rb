module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    before_action :set_user_locale

    rescue_from ActiveRecord::RecordNotFound do
      redirect_to '/404', alert: "Oops! The page you're looking for does not exist."
    end
    rescue_from CanCan::AccessDenied do
      redirect_to '/404', alert: "Oops! The page you're looking for does not exist."
    end

    private

    def set_user_locale
      I18n.locale = current_user&.locale || I18n.default_locale
    end
  end
end
