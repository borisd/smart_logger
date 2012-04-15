module ActiveSupport
  class BufferedLogger
    def add(severity, message = nil, progname = nil, &block)
      return if @level > severity
      message ||= (block && block.call) 
      severity = ActiveSupport::BufferedLogger::Severity.constants[severity].to_s
      message = SmartLogger::format_message(severity, message, progname)
      buffer << message
      auto_flush
      message
    end
  end
end
