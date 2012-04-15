class Logger
  class SimpleFormatter
    def call(severity, time, progname, msg)
      SmartLogger::format_message(severity, msg2str(msg), progname)
    end
  end
end
