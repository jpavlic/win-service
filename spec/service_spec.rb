require 'spec_helper'

describe Win::Service do
  before do
    @remote_service = Win::Service.new("W3SVC", "10.30.0.62", "Administrator", "passpass00")
  end

  it "should give the status of running when the service has been started" do
    @remote_service.stub!(:service_status).and_return("running")
    @remote_service.status.should == "running"
  end

  it "should confirm that the service has been started" do
    @remote_service.stub!(:start_service).and_return(true)
    @remote_service.start.should be_true
  end

  it "should give an error if the service was already started when starting" do
    @remote_service.stub!(:start_service).and_return(Win::ServiceErrors::Errors.error_from_code("0x00000420").error)
    @remote_service.start.should == "An instance of the service is already running."
  end

  it "should give the status of running when the service has been stopped" do
    @remote_service.stub!(:service_status).and_return("stopped")
    @remote_service.status.should == "stopped"
  end

  it "should give an error if the service was already stopped when stopping" do
    @remote_service.stub!(:stop_service).and_return(Win::ServiceErrors::Errors.error_from_code("0x00000426").error)
    @remote_service.stop.should == "The service has not been started."
  end

  it "should confirm that the service has been stopped" do
    @remote_service.stub!(:stop_service).and_return(true)
    @remote_service.stop.should be_true
  end

  it "should give the status of pending when the service is being stopped" do
    @remote_service.stub!(:service_status).and_return("pending")
    @remote_service.status.should == "pending"
  end

  it "should confirm that the service has been paused" do
    @remote_service.stub!(:pause_service).and_return(true)
    @remote_service.pause.should be_true
  end

  it "should give the status of paused when the service has been paused" do
    @remote_service.stub!(:service_status).and_return("paused")
    @remote_service.status.should == "paused"
  end

  it "should confirm that the service has been resumed" do
    @remote_service.stub!(:resume_service).and_return(true)
    @remote_service.resume.should be_true
  end

  it "should give the status of started when the service has been resumed" do
    @remote_service.stub!(:service_status).and_return("running")
    @remote_service.status.should == "running"
  end
end
