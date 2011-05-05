module Win
  module ServiceController
    module WindowsService
      def start_service
        execute_service_control_command(service_control_for :start)
      end

      def stop_service
        execute_service_control_command(service_control_for :stop)
      end

      def pause_service
         execute_service_control_command(service_control_for :pause)
      end

      def resume_service
        execute_service_control_command(service_control_for :continue)
      end

      def service_status
        result = execute_service_control_command(service_control_for :query)

        status = remove_tabs_from_string(result).split("\n").find_all{|item| item =~ /STATE/}[0].scan(/\w+/).last.downcase
        status = "pending" if status.include? "pending"

        status
      end

      private

      def execute_shell_command(command)
        %x[#{command}]
      end

      def execute_service_control_command(service_control_command)
        logon # required to authenticate
        result = execute_shell_command(service_control_command)

        extract_error_code_from_results(result) if result.upcase.include? "FAILED"
        return result if service_control_command.include? 'query'
      end
      
      def remove_tabs_from_string(result)
        result.gsub("\t", "")
      end

      def extract_error_code_from_results(result)
        raise ServiceErrors::Errors.error_from_code(result).error
      end

      def service_control_for(command)
        "sc \\\\#{@host} #{command.to_s} #{@name}"
      end

      def login_command
        #net use \\ADDRESS\IPC$ PASSWORD /user:USERWITHDOMAIN
        "net use \\\\#{@host}\\IPC$ #{@password} /user:#{@host}\\#{@user}"
      end

      def logon
        result = %x[#{login_command}].gsub("\n", "")
      end
    end
  end
end