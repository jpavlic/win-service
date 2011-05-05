module Win
  module ServiceErrors
    class Error
      attr_reader :error

      def initialize(error)
        @error = error
      end
    end

    class Errors
      @errors = {
        "0x0000041B"=> "A stop control has been sent to a service that other running services are dependent on.",
        "0x0000041C" => "The requested control is not valid for this service.",
        "0x0000041D" => "The service did not respond to the start or control request in a timely fashion.",
        "0x0000041E" => "A thread could not be created for the service.",
        "0x0000041F" => "The service database is locked.",
        "0x00000420" => "An instance of the service is already running.",
        "0x00000421" => "The account name is invalid or does not exist, or the password is invalid for the account name specified.",
        "0x00000422" => "The service cannot be started, either because it is disabled or because it has no enabled devices associated with it.",
        "0x00000423" => "Circular service dependency was specified.",
        "0x00000424" => "The specified service does not exist as an installed service.",
        "0x00000425" => "The service cannot accept control messages at this time.",
        "0x00000426" => "The service has not been started.",
        "0x00000427" => "The service process could not connect to the service controller.",
        "0x00000428" => "An exception occurred in the service when handling the control request.",
        "0x00000429" => "The database specified does not exist.",
        "0x0000042A" => "The service has returned a service-specific error code.",
        "0x0000042B" => "The process terminated unexpectedly.",
        "0x0000042C" => "The dependency service or group failed to start.",
        "0x0000042D" => "The service did not start due to a logon failure.",
        "0x0000042E" => "After starting, the service hung in a start-pending state.",
        "0x0000042F" => "The specified service database lock is invalid.",
        "0x00000430" => "The specified service has been marked for deletion.",
        "0x00000431" => "The specified service already exists.",
        "0x00000432" => "The system is currently running with the last-known-good configuration.",
        "0x00000433" => "The dependency service does not exist or has been marked for deletion.",
        "0x00000434" => "The current boot has already been accepted for use as the last-known-good control set.",
        "0x00000435" => "No attempts to start the service have been made since the last boot.",
        "0x00000436" => "The name is already in use as either a service name or a service display name.",
        "0x00000437" => "The account specified for this service is different from the account specified for other services running in the same process.",
        "0x00000438" => "Failure actions can only be set for Win32 services, not for drivers.",
        "0x00000439" => "This service runs in the same process as the service control manager. Therefore, the service control manager cannot take action if this service's process terminates unexpectedly.",
        "0x0000043A" => "No recovery program has been configured for this service.",
        "0x0000043B" => "The executable program that this service is configured to run in does not implement the service."
        }

      def self.error_from_code(code)
        result = @errors[code]

        return Error.new("#{code}") if result.nil?

        Error.new(result)
      end
    end
  end
end