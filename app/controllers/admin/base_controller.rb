module Admin
  class BaseController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource

    rescue_from ActiveRecord::RecordNotFound do
      redirect_to '/404', alert: "Oops! The page you're looking for does not exist."
    end
    rescue_from CanCan::AccessDenied do
      redirect_to '/404', alert: "Oops! The page you're looking for does not exist."
    end
  end
end
