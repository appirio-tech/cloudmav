ENV["REDISTOGO_URL"] ||= "redis://localhost/"

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)

require 'resque/job_with_status'