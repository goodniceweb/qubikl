module Admin
  class UsersController < ::Admin::BaseController
    load_and_authorize_resource

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_back fallback_location: root_path, notice: t('controllers.users.update.success')
      else
        redirect_back fallback_location: root_path, notice: t('controllers.users.update.failed')
      end
    end

    private

    def user_params
      params.fetch(:user, {}).permit(:locale)
    end
  end
end
