# Mark beginning of all rack tasks
module SmartLogger
  class RackLoggerMarker
    def initialize(app)
      @app = app
    end

    def call(env)
      SmartLogger.start "Rack"
      @app.call(env)
      SmartLogger.end
    end
  end
end

