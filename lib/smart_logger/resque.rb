# Included in Resque jobs to setup log.
#
# Usage:
#   class Something
#     extend SmartLogger::Job
#   end
module SmartLogger
  module Job
    def around_perform_log_job(*args)
      SmartLogger.start "Job:#{ self.to_s }"
      begin
        yield
      rescue
        raise
      ensure
        SmartLogger.end
        ::Rails.logger.flush
      end
    end
  end
end


