module ApplicationHelper
  def options_for_domain(_current_user)
    [
      [request.host_with_port, request.base_url],
      # hardcode for test purposes
      ["goodniceweb.me", "goodniceweb.me"]
    ]
  end
end
