class API::V1::QRCodesController < ActionController::API
  # include JSONAPI::ActsAsResourceController

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
end
