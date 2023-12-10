class StoreVisitJob < ApplicationJob
  queue_as :default

  IPDB = MaxMind::GeoIP2::Reader.new(
    database: Rails.root.join('vendor', 'data', 'GeoLite2-Country.mmdb').to_s
  )

  def perform(qr_code_id, visitor_ip, user_agent_string, referrer)
    qr_code = QRCode.find_by(id: qr_code_id)
    return if qr_code.blank?

    user_agent = UserAgentParser.parse(user_agent_string)
    Visit.transaction do
      qr_code.visits_amount += 1
      qr_code.save

      country_iso_code =
        begin
          IPDB.country(visitor_ip).country.iso_code
        rescue MaxMind::GeoIP2::AddressNotFoundError
          nil
        end

      Visit.create(
        qr_code: qr_code,
        country: country_iso_code,
        referrer: referrer,
        device: user_agent.device.brand,
        os: user_agent.os.to_s
      )
    end
  end
end
