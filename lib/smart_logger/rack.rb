# Mark beginning of all rack tasks
module SmartLogger
  class RackLoggerMarker
    def initialize(app)
      @app = app
    end

    def call(env)
      SmartLogger.start "Rack"
      rc = @app.call(env)
      SmartLogger.end
      rc
    end
  end
end

