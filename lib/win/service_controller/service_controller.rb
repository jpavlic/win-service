require 'win/service_controller/unix_service'
require 'win/service_controller/windows_service'

module Win
  module ServiceController
    def self.included(clz)
      if Config::CONFIG['host_os'] =~ /mingw32/
        clz.send :include, WindowsService
      else
        clz.send :include, UnixService
      end
    end
  end
end