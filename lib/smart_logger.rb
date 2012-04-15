require 'securerandom'

require 'smart_logger/active_support'
require 'smart_logger/logger'
require 'smart_logger/rack'
require 'smart_logger/resque'

module SmartLogger

  # Mark the start of a new action, creating a new water-mark
  #
  # Example:
  #   SmartLogger.start('Worker 3')
  #
  # @action [String] A textual tag to append to log
  #
  def self.start(action)
    create_watermark
    save_param(:action, action)
  end

  # Mark the end of an action
  #
  def self.end
    create_watermark
    reset_params
  end

  # Adds extra tags to the log file
  #
  # Example:
  #   SmartLogger.add(:remote_ip, '#{IP}')
  #
  # @name [String] Name of parameter
  # @value [String] Value of parameter
  #
  def self.add(name, value)
    create_watermark if self.water_mark.nil?
    save_param(name, value)
  end

  # Returns a list of parameters for this action
  #
  # @return A string containing name:value pairs
  #
  def self.params
    Thread.current[:logger_params].inject('') do |str, val| 
      str << " #{val[0].to_s}:#{val[1]}" 
    end rescue ''
  end

  # Returns the current water mark
  #
  # @return String representing water mark
  #
  def self.water_mark
    Thread.current[:logger_mark]
  end

  # Initialize smart logger
  #
  # Example:
  #   SmartLogger.initialize('InitProcess')
  #
  # @name [String] Default action name before first "start" call
  #
  def self.initialize(name = 'InitProcess')
    Rails.configuration.middleware.insert_before Rails::Rack::Logger, SmartLogger::RackLoggerMarker
    SmartLogger.start(name)
  end

  def self.format_message(severity, message = nil, progname = nil)
    "[%s%s] [%s: %s] %s\n" % [
      SmartLogger::water_mark,
      SmartLogger::params,
      severity,
      Time.zone.now.strftime("%H:%M:%S"),
      (message || progname).to_s.lstrip]
  end

  private
    def self.create_watermark
      Thread.current[:logger_mark] = "WM##{SecureRandom.hex(5)}"
    end

    def self.reset_params
      Thread.current[:logger_params] = { }
    end

    def self.save_param(name, value)
      Thread.current[:logger_params] ||= {}
      Thread.current[:logger_params][name] = value
    end
end

