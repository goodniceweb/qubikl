class QRCodesController < ApplicationController
  # GET /:hex
  def show
    @qr_code = QRCode.find_by!(path_alias: params[:path_alias])

    StoreVisitJob.perform_later(@qr_code.id, request.remote_ip, request.user_agent, request.referrer)

    redirect_to @qr_code.destination, allow_other_host: true
  end
end
