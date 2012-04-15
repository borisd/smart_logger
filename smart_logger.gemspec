Gem::Specification.new do |s|
  s.name        = 'smart_logger'
  s.version     = '0.1.0'
  s.date        = '2012-04-15'
  s.summary     = "Smart tagged log"
  s.description = "Smart grouping of log entries"
  s.authors     = ["Boris Dinkevich"]
  s.email       = 'do@itlater.com'
  s.homepage    = 'https://github.com/borisd/smart_logger'
  s.files       = ["lib/smart_logger.rb", 
                   "lib/smart_logger/active_support.rb",
                   "lib/smart_logger/logger.rb",
                   "lib/smart_logger/rack.rb",
                   "lib/smart_logger/resque.rb",
                  ]
end


