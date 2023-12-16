class API::V1::QRCodesController < ActionController::API
  # include JSONAPI::ActsAsResourceController
  before_action :authenticate!

  def index
    render jsonapi: QRCode.all
  end

  def show
    render jsonapi: QRCode.find(params[:id])
  end

  def create
    qr_code = QRCode.new(qr_code_params)

    if qr_code.save
      render jsonapi: qr_code
    else
      render jsonapi_errors: qr_code.errors
    end
  end

  private

  attr_reader :active_user

  def authenticate!
    unless valid_token?
      render json: { error: 'Unauthenticated' }, status: :unauthorized
    end
  end

  def valid_token?
    header = request.headers['Authorization']
    secret = header&.split(' ')&.last
    api_key = APIKey.find_by(secret:)
    return false unless api_key

    @active_user = api_key.user
  end

  def qr_code_params
    params[:qr_code][:user_id] = @active_user.id
    domain = params[:qr_code][:domain]
    user_domain = UserDomain.find_by(user_id: @active_user.id, name: domain)
    params[:qr_code][:user_domain_id] = user_domain.id if user_domain.present?
    params.fetch(:qr_code, {}).permit(:destination, :domain, :user_id, :user_domain_id)
  end
end
