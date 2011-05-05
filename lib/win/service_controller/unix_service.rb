require 'open3'

module Win
  module ServiceController
    module UnixService
      def start_service
        execute_net_rpc_command :start
      end

      def stop_service
        execute_net_rpc_command :stop
      end

      def service_status
        result = execute_net_rpc_command :status
        status = remove_tabs_from_string(result).split("\n")[0].scan(/\w+/)
        return status[status.size-1]
      end

      def pause_service
        execute_net_rpc_command :pause
      end

      def resume_service
        execute_net_rpc_command :resume
      end

      private

      def execute_net_rpc_command(command)
        stdin, stdout, stderr = Open3.popen3(net_rpc_for command.to_s)
        out = stdout.read
        err = stderr.read

        error_code = err.scan(/0x00000\d*/)[0] if err.size > 0
        error_code = err.gsub("\n", "") if error_code.nil?

        raise ServiceErrors::Errors.error_from_code(error_code).error unless err.size == 0
        out if command.to_s == 'status'
      end

      def net_rpc_for(command)
        "net rpc -I #{@host} -U #{@user}%#{@password} service #{command} #{@name}"
      end

      def remove_tabs_from_string(result)
        result.gsub("\t", "")
      end
    end
  end
end