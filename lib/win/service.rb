require 'rbconfig'
require 'win/service_controller'

module Win
  class Service
    VERSION = '0.1.0'
    include Win::ServiceController

    def initialize(service_name, service_address, user_name, user_password)
      @name = service_name
      @host = service_address
      @user = user_name
      @password = user_password
    end

    def start
      start_service
    end

    def stop
      stop_service
    end

    def pause
      pause_service
    end

    def resume
      resume_service
    end

    def status
      service_status
    end
  end
end