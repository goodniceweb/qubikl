module Admin
  class UserDomainsController < ::Admin::BaseController
    before_action :set_user_domain, only: [:show, :edit, :update, :destroy]

    # GET /user_domains
    def index
      @user_domains = UserDomain.where(user_id: current_user.id).all
    end

    # GET /user_domains/1
    def show
    end

    # GET /user_domains/new
    def new
      @user_domain = UserDomain.new(user: current_user)
    end

    # GET /user_domains/1/edit
    def edit
    end

    # POST /user_domains
    def create
      @user_domain = UserDomain.new(user_domain_params)

      if @user_domain.save
        redirect_to user_domains_url, notice: 'Domain was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /user_domains/1
    def update
      if @user_domain.update(user_domain_params)
        redirect_to user_domains_url, notice: 'Domain was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /user_domains/1
    def destroy
      @user_domain.destroy
      redirect_to user_domains_url, notice: 'Domain was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_user_domain
      @user_domain = UserDomain.where(user_id: current_user.id).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_domain_params
      params[:user_domain][:user_id] = current_user.id
      params.fetch(:user_domain, {}).permit(:name, :user_id)
    end
  end
end
