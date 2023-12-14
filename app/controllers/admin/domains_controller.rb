module Admin
  class DomainsController < ::Admin::BaseController
    before_action :set_user_domain, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: UserDomain

    # GET /domains
    def index
      @user_domains = UserDomain.where(user_id: current_user.id).all
    end

    # GET /domains/1
    def show
    end

    # GET /domains/new
    def new
      @user_domain = UserDomain.new(user: current_user)
    end

    # GET /domains/1/edit
    def edit
    end

    # POST /domains
    def create
      @user_domain = UserDomain.new(domain_params)

      if @user_domain.save
        redirect_to user_domains_url, notice: t('controllers.user_domains.create.success')
      else
        render :new
      end
    end

    # PATCH/PUT /domains/1
    def update
      if @user_domain.update(domain_params)
        redirect_to user_domains_url, notice: t('controllers.user_domains.update.success')
      else
        render :edit
      end
    end

    # DELETE /domains/1
    def destroy
      @user_domain.destroy
      redirect_to user_domains_url, notice: t('controllers.user_domains.destroy.success')
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user_domain
      @user_domain = UserDomain.where(user_id: current_user.id).find(params[:id])
    end

    # This method has to be named domain_params because of the way CanCanCan works
    def domain_params
      params[:user_domain][:user_id] = current_user.id
      params.fetch(:user_domain, {}).permit(:name, :user_id)
    end
  end
end
