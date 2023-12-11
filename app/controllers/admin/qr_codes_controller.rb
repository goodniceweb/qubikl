module Admin
  class QRCodesController < ApplicationController
    before_action :authenticate_user!
    load_and_authorize_resource
    before_action :set_qr_code, only: [:show, :edit, :update, :destroy]

    rescue_from ActiveRecord::RecordNotFound do
      redirect_to '/404', alert: "Oops! The page you're looking for does not exist."
    end
    rescue_from CanCan::AccessDenied do
      redirect_to '/404', alert: "Oops! The page you're looking for does not exist."
    end


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
        redirect_to qr_codes_url, notice: 'QR code was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /qr_codes/1
    def update
      if @qr_code.update(qr_code_params)
        redirect_to qr_codes_url, notice: 'QR code was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /qr_codes/1
    def destroy
      @qr_code.destroy
      redirect_to qr_codes_url, notice: 'QR code was successfully destroyed.'
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_qr_code
      @qr_code = QRCode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def qr_code_params
      params[:qr_code][:user_id] = current_user.id
      domain = extract_domain(params[:qr_code][:domain])
      params[:qr_code][:domain] = domain
      params.fetch(:qr_code, {}).permit(:destination, :domain, :user_id)
    end

    def extract_domain(domain_param)
      return request.base_url unless domain_param.is_a?(Array)

      domain_param.reject(&:blank?).last
    end
  end
end
