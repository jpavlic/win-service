require "rspec"

RSpec.configure do |config|
  if Config::CONFIG['host_os'] =~ /darwin/
    config.filter_run_excluding :windows => true
  end
end

describe Win::ServiceController::WindowsService, :windows => true do
  describe "when service status is being requested" do
    let(:service) {Win::Service.new('Service', '127.0.0.1', 'admin', 'password')}
    
    it "should successfully return running when the service is started" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("\nSERVICE_NAME: W3SVC\n\t\tTYPE               : 20  WIN32_SHARE_PROCESS\n\t\tSTATE              : 4  RUNNING\n\t\t\t\t\t\t\t\t(STOPPABLE, NOT_PAUSABLE, ACCEPTS_SHUTDOWN)\n\t\tWIN32_EXIT_CODE    : 0  (0x0)\n\t\tSERVICE_EXIT_CODE  : 0  (0x0)\n\t\tCHECKPOINT         : 0x0\n\t\tWAIT_HINT          : 0x0\n")
      service.status.should == "running"
    end

    it "should successfully return stopped when the service is stopped" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("\nSERVICE_NAME: W3SVC\n\t\tTYPE               : 20  WIN32_SHARE_PROCESS\n\t\tSTATE              : 1  STOPPED\n\t\t\t\t\t\t\t\t(STOPPABLE, NOT_PAUSABLE, ACCEPTS_SHUTDOWN)\n\t\tWIN32_EXIT_CODE    : 0  (0x0)\n\t\tSERVICE_EXIT_CODE  : 0  (0x0)\n\t\tCHECKPOINT         : 0x0\n\t\tWAIT_HINT          : 0x0\n")
      service.status.should == "stopped"
    end

    it "should successfully return pending when the service is stopping" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("\nSERVICE_NAME: W3SVC\n\t\tTYPE               : 20  WIN32_SHARE_PROCESS\n\t\tSTATE              : 3  STOP_PENDING\n\t\t\t\t\t\t\t\t(NOT_STOPPABLE, NOT_PAUSABLE, IGNORESs_SHUTDOWN)\n\t\tWIN32_EXIT_CODE    : 0  (0x0)\n\t\tSERVICE_EXIT_CODE  : 0  (0x0)\n\t\tCHECKPOINT         : 0x0\n\t\tWAIT_HINT          : 0x0\n")
      service.status.should == "pending"
    end

    it "should successfully return paused when the service is paused" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("\nSERVICE_NAME: W3SVC\n\t\tTYPE               : 20  WIN32_SHARE_PROCESS\n\t\tSTATE              : 7  PAUSED\n\t\t\t\t\t\t\t\t(NOT_STOPPABLE, NOT_PAUSABLE, IGNORES_SHUTDOWN)\n\t\tWIN32_EXIT_CODE    : 0  (0x0)\n\t\tSERVICE_EXIT_CODE  : 0  (0x0)\n\t\tCHECKPOINT         : 0x0\n\t\tWAIT_HINT          : 0x0\n")
      service.status.should == "paused"
    end
  end

  describe "when service is being controlled" do
    let(:service) {Win::Service.new('Service', '127.0.0.1', 'admin', 'password')}

    it "should successfully start a stopped service" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("\nSERVICE_NAME: W3SVC\n\t\tTYPE               : 20  WIN32_SHARE_PROCESS\n\t\tSTATE              : 2  START_PENDING\n\t\t\t\t\t\t\t\t(NOT_STOPPABLE, NOT_PAUSABLE, IGNORES_SHUTDOWN)\n\t\tWIN32_EXIT_CODE    : 0  (0x0)\n\t\tSERVICE_EXIT_CODE  : 0  (0x0)\n\t\tCHECKPOINT         : 0x0\n\t\tWAIT_HINT          : 0x7d0\n\t\tPID                : 632\n\t\tFLAGS              :\n")
      expect { service.start }.should_not raise_error
    end

    it "should successfully stop a started service" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("\nSERVICE_NAME: W3SVC\n\t\tTYPE               : 20  WIN32_SHARE_PROCESS\n\t\tSTATE              : 3  STOP_PENDING\n\t\t\t\t\t\t\t\t(NOT_STOPPABLE, NOT_PAUSABLE, IGNORES_SHUTDOWN)\n\t\tWIN32_EXIT_CODE    : 0  (0x0)\n\t\tSERVICE_EXIT_CODE  : 0  (0x0)\n\t\tCHECKPOINT         : 0x1\n\t\tWAIT_HINT          : 0x4e20\n")
      expect { service.stop }.should_not raise_error
    end

    it "should successfully pause a started service" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("\nSERVICE_NAME: W3SVC\n\t\tTYPE               : 20  WIN32_SHARE_PROCESS\n\t\tSTATE              : 6  PAUSE_PENDING\n\t\t\t\t\t\t\t\t(NOT_STOPPABLE, NOT_PAUSABLE, IGNORES_SHUTDOWN)\n\t\tWIN32_EXIT_CODE    : 0  (0x0)\n\t\tSERVICE_EXIT_CODE  : 0  (0x0)\n\t\tCHECKPOINT         : 0x1\n\t\tWAIT_HINT          : 0x4e20\n")
      expect { service.pause }.should_not raise_error
    end

    it "should successfully resume a paused service" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("\nSERVICE_NAME: W3SVC\n\t\tTYPE               : 20  WIN32_SHARE_PROCESS\n\t\tSTATE              : 5  CONTINUE_PENDING\n\t\t\t\t\t\t\t\t(NOT_STOPPABLE, NOT_PAUSABLE, IGNORES_SHUTDOWN)\n\t\tWIN32_EXIT_CODE    : 0  (0x0)\n\t\tSERVICE_EXIT_CODE  : 0  (0x0)\n\t\tCHECKPOINT         : 0x1\n\t\tWAIT_HINT          : 0x4e20\n")
      expect { service.resume }.should_not raise_error
    end

    it "should raise an error when trying to stop an already stopped service" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("[SC] ControlService FAILED 1061:\n\nThe service cannot accept control messages at this time.")
      expect { service.stop }.should raise_error
    end

    it "should raise an error when trying to start an already started service" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("[SC] ControlService FAILED 1056:\n\nAn instance of the service is already running.")
      expect { service.start }.should raise_error
    end

    it "should raise an error when trying to start an already started service" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("[SC] ControlService FAILED 1056:\n\nAn instance of the service is already running.")
      expect { service.start }.should raise_error
    end

    it "should raise an error when trying to pause an already stopped service" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("[SC] ControlService FAILED 1062:\n\nAn instance of the service is already running.")
      expect { service.pause }.should raise_error
    end

    it "should raise an error when trying to resume an already stopped service" do
      service.should_receive(:send).with(:include, Win::ServiceController::WindowsService)
      Win::ServiceController.included(service)
      service.stub!(:logon).and_return("")
      service.stub!(:execute_shell_command).and_return("[SC] ControlService FAILED 1062:\n\nAn instance of the service is already running.")
      expect { service.resume }.should raise_error
    end
  end
end