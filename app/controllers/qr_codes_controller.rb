class QrCodesController < ApplicationController
  before_action :set_qr_code, only: [:edit, :update, :destroy]

  # GET /qr_codes
  def index
    @qr_codes = QrCode.all
  end

  # GET /:hex
  def show
    @qr_code = QrCode.find_by!(external_id: params[:external_id])
    @qr_code.scans += 1
    @qr_code.save
    redirect_to @qr_code.data
  end

  # GET /qr_codes/new
  def new
    @qr_code = QrCode.new
  end

  # GET /qr_codes/1/edit
  def edit
  end

  # POST /qr_codes
  def create
    @qr_code = QrCode.new(qr_code_params)

    if @qr_code.save
      redirect_to qr_codes_url, notice: 'Qr code was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /qr_codes/1
  def update
    if @qr_code.update(qr_code_params)
      redirect_to qr_codes_url, notice: 'Qr code was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /qr_codes/1
  def destroy
    @qr_code.destroy
    redirect_to qr_codes_url, notice: 'Qr code was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_qr_code
      @qr_code = QrCode.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def qr_code_params
      params.fetch(:qr_code, {}).permit(:data)
    end
end
