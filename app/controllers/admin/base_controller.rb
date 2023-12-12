module Admin
  class BaseController < ApplicationController
    include Localizeable

    before_action :authenticate_user!

    rescue_from ActiveRecord::RecordNotFound do
      redirect_to '/404', alert: "Oops! The page you're looking for does not exist."
    end
    rescue_from CanCan::AccessDenied do
      redirect_to '/404', alert: "Oops! The page you're looking for does not exist."
    end
  end
end
