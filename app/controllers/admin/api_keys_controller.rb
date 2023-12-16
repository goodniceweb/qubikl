module Admin
  class APIKeysController < ::Admin::BaseController
    before_action :set_api_key, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource class: APIKey

    # GET /api_keys
    def index
      @api_keys = APIKey.where(user_id: current_user.id).all
    end

    # GET /api_keys/1
    def show
    end

    # GET /api_keys/new
    def new
      @api_key = APIKey.new(user: current_user)
    end

    # GET /api_keys/1/edit
    def edit
    end

    # POST /api_keys
    def create
      @api_key = APIKey.new(api_key_params)

      if @api_key.save
        redirect_to api_keys_url, notice: t('controllers.api_keys.create.success')
      else
        render :new
      end
    end

    # PATCH/PUT /api_keys/1
    def update
      if @api_key.update(api_key_params)
        redirect_to api_keys_url, notice: t('controllers.api_keys.update.success')
      else
        render :edit
      end
    end

    # DELETE /api_keys/1
    def destroy
      @api_key.destroy
      redirect_to api_keys_url, notice: t('controllers.api_keys.destroy.success')
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_api_key
      @api_key = APIKey.where(user_id: current_user.id).find(params[:id])
    end

    def api_key_params
      params[:api_key][:user_id] = current_user.id
      params.fetch(:api_key, {}).permit(:name, :user_id)
    end
  end
end
