module ApplicationHelper
  def options_for_domain(user)
    user.domains.pluck(:name).unshift(request.host_with_port).map { |domain| [domain, domain] }
  end
end
