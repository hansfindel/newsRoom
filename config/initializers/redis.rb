#uri = URI.parse(ENV["REDISTOGO_URL"])
#REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)


env = Rails.env 
if env == "production" || env == "staging" || env == "heroku_production" #|| env == "development"
	REDIS = Redis.new(:host => 'localhost', :port => 6379, :db => 0) 
end