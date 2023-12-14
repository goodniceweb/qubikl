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
    post = Post.new(params[:post])

    if post.save
      render jsonapi: post
    else
      render jsonapi_errors: post.errors
    end
  end

  private

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

  def active_user
    @active_user
  end
end
