require "rspec"

RSpec.configure do |config|
  if Config::CONFIG['host_os'] =~ /mingw32/
    config.filter_run_excluding :unix => true
  end
end

describe Win::ServiceController::UnixService, :unix => true do
  
  describe "when service status is being requested" do
    let(:service) {Win::Service.new('Service', '127.0.0.1', 'admin', 'password')}
    let(:stdout) {double('stdout')}
    let(:stderr) {double('stderr')}
    let(:stdin) {double('stdin')}

    it "should successfully return running when the service is started" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return("W3SVC service is running.\nConfiguration details:\n\tControls Accepted    = 0x7\n\tService Type         = 0x20\n\tStart Type           = 0x2\n\tError Control        = 0x1\n\tTag ID               = 0x0\n\tExecutable Path      = C:\\WINDOWS\\System32\\svchost.exe -k iissvcs\n\tLoad Order Group     = \n\tDependencies         = RPCSS/HTTPFilter/IISADMIN/\n\tStart Name           = LocalSystem\n\tDisplay Name         = World Wide Web Publishing Service\n")
      stderr.should_receive(:read).and_return('')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      service.status.should == "running"
    end

    it "should successfully return stopped when the service is stopped" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return("W3SVC service is stopped.\nConfiguration details:\n\tControls Accepted    = 0x0\n\tService Type         = 0x20\n\tStart Type           = 0x2\n\tError Control        = 0x1\n\tTag ID               = 0x0\n\tExecutable Path      = C:\\WINDOWS\\System32\\svchost.exe -k iissvcs\n\tLoad Order Group     = \n\tDependencies         = RPCSS/HTTPFilter/IISADMIN/\n\tStart Name           = LocalSystem\n\tDisplay Name         = World Wide Web Publishing Service\n")
      stderr.should_receive(:read).and_return('')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      service.status.should == "stopped"
    end

    it "should successfully return pending when the service is stopping" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return("W3SVC service is stop pending.\nConfiguration details:\n\tControls Accepted    = 0x5\n\tService Type         = 0x10\n\tStart Type           = 0x3\n\tError Control        = 0x1\n\tTag ID               = 0x0\n\tExecutable Path      = \"C:\\Program Files\\Virtual Hold Technology\\VHT_QueueManager_Service.exe\"\n\tLoad Order Group     = \n\tDependencies         = /\n\tStart Name           = LocalSystem\n\tDisplay Name         = VHT_QueueManager\n")
      stderr.should_receive(:read).and_return('')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      service.status.should == "pending"
    end

    it "should successfully return paused when the service is paused" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return("W3SVC service is paused.\nConfiguration details:\n\tControls Accepted    = 0x7\n\tService Type         = 0x20\n\tStart Type           = 0x2\n\tError Control        = 0x1\n\tTag ID               = 0x0\n\tExecutable Path      = C:\\WINDOWS\\System32\\svchost.exe -k iissvcs\n\tLoad Order Group     = \n\tDependencies         = RPCSS/HTTPFilter/IISADMIN/\n\tStart Name           = LocalSystem\n\tDisplay Name         = World Wide Web Publishing Service\n")
      stderr.should_receive(:read).and_return('')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      service.status.should == "paused"
    end
  end

  describe "when service is being controlled" do
    let(:service) {Win::Service.new('Service', '127.0.0.1', 'admin', 'password')}
    let(:stdout) {double('stdout')}
    let(:stderr) {double('stderr')}
    let(:stdin) {double('stdin')}

    it "should successfully start a stopped service" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return('..\nSuccessfully started service: VHT_QueueManager\n')
      stderr.should_receive(:read).and_return('')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      expect { service.start }.should_not raise_error
    end

    it "should successfully stop a started service" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return('..............................\nVHT_QueueManager service is stop pending.\n')
      stderr.should_receive(:read).and_return('')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      expect { service.stop }.should_not raise_error
    end

    it "should successfully pause a started service" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return('service pause W3SVC\n.\nW3SVC service is paused.')
      stderr.should_receive(:read).and_return('')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      expect { service.pause }.should_not raise_error
    end

    it "should successfully resume a paused service" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return('service resume W3SVC\n.\nW3SVC service is running.')
      stderr.should_receive(:read).and_return('')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      expect { service.resume }.should_not raise_error
    end

    it "should raise an error when trying to stop an already stopped service" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return('')
      stderr.should_receive(:read).and_return('Control service request failed.  [DOS code 0x00000426]')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      expect { service.stop }.should raise_error
    end

    it "should raise an error when trying to start an already started service" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return('')
      stderr.should_receive(:read).and_return('Query status request failed.  [DOS code 0x00000420]')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      expect { service.stop }.should raise_error
    end

    it "should raise an error when trying to pause an already stopped service" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return('')
      stderr.should_receive(:read).and_return('Control service request failed.  [DOS code 0x00000426]')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      expect { service.pause }.should raise_error
    end

    it "should raise an error when trying to resume an already stopped service" do
      service.should_receive(:send).with(:include, Win::ServiceController::UnixService)

      stdout.should_receive(:read).and_return('')
      stderr.should_receive(:read).and_return('Control service request failed.  [DOS code 0x00000426]')

      Win::ServiceController.included(service)
      Open3.stub!(:popen3).and_return([stdin, stdout, stderr])
      expect { service.resume }.should raise_error
    end

  end
end