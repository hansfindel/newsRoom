uri = URI.parse(ENV["REDISTOGO_URL"])
#REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
REDIS = Redis.new(:host => 'localhost', :port => 6379, :db => 0)