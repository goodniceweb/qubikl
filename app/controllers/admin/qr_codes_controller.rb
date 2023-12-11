module Admin
  class QRCodesController < ::Admin::BaseController
    before_action :set_qr_code, only: [:show, :edit, :update, :destroy]
    load_and_authorize_resource

    # GET /qr_codes
    def index
      @qr_codes = QRCode.where(user_id: current_user.id).all
    end

    # GET /qr_codes/1
    def show
      scope = Visit.where(qr_code_id: params[:id])
      @countries = scope.pluck(:country).join(',')
      @os_data = scope.group(:os).count
      @device_data = scope.group(:device).count
    end

    # GET /qr_codes/new
    def new
      @qr_code = QRCode.new(user: current_user)
    end

    # GET /qr_codes/1/edit
    def edit
    end

    # POST /qr_codes
    def create
      @qr_code = QRCode.new(qr_code_params)

      if @qr_code.save
        redirect_to qr_codes_url, notice: t('controllers.qr_codes.create.success')
      else
        render :new
      end
    end

    # PATCH/PUT /qr_codes/1
    def update
      if @qr_code.update(qr_code_params)
        redirect_to qr_codes_url, notice: t('controllers.qr_codes.update.success')
      else
        render :edit
      end
    end

    # DELETE /qr_codes/1
    def destroy
      @qr_code.destroy
      redirect_to qr_codes_url, notice: t('controllers.qr_codes.destroy.success')
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_qr_code
      @qr_code = QRCode.where(user_id: current_user.id).find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def qr_code_params
      params[:qr_code][:user_id] = current_user.id
      domain = extract_domain(params[:qr_code][:domain])
      user_domain = UserDomain.find_by(user_id: current_user.id, name: domain)
      params[:qr_code][:user_domain_id] = user_domain.id if user_domain.present?
      params[:qr_code][:domain] = domain
      params.fetch(:qr_code, {}).permit(:destination, :domain, :user_id, :user_domain_id)
    end

    def extract_domain(domain_param)
      return request.base_url unless domain_param.is_a?(Array)

      domain_param.reject(&:blank?).last
    end
  end
end
