ENV["REDISTOGO_URL"] ||= "redis://localhost/"

require 'resque/job_with_status'
require 'resque/status_server'

uri = URI.parse(ENV["REDISTOGO_URL"])
Resque.redis = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
Resque::Status.expire_in = (24 * 60 * 60) # 24hrs in seconds

Resque::Server.use(Rack::Auth::Basic) do |user, password|  
  password == "penny"  
end

