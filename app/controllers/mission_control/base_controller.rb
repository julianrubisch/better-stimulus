module MissionControl
  mattr_writer :username
  mattr_writer :password

  class << self
    # use method instead of attr_accessor to ensure
    # this works if variable set after SolidErrors is loaded
    def username
      @username ||= @@username || ENV.fetch("MISSION_CONTROL_USERNAME", "admin")
    end

    def password
      @password ||= @@password || ENV.fetch("MISSION_CONTROL_PASSWORD", SecureRandom.hex(16))
    end
  end

  class BaseController < ActionController::Base
    protect_from_forgery with: :exception

    http_basic_authenticate_with name: MissionControl.username, password: MissionControl.password
  end
end
