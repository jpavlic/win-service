require 'spec_helper'

RSpec.configure do |config|
  if RbConfig::CONFIG['host_os'] =~ /darwin/
    config.filter_run_excluding :windows => true
  end
end

describe Win::ServiceController do
  describe "when module is loaded on Windows", :windows => true do
    let(:service) { double('service')}

    it "should extend the WindowsService module when on Windows platform" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
    end
  end

  describe "when module is loaded on UNIX", :unix => true do
    let(:service) { double('service')}
      it "should extend the UnixService module when on the OS X platform" do
        service.should_receive(:send).with(:include, Win::ServiceController::UnixService)
        Win::ServiceController.included(service)
    end
  end
end