#REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)


env = Rails.env 

env_eq = (env == "staging" || env == "heroku_production" ) #|| env == "production" ||  env == "development"

if env_eq 
	uri = URI.parse(ENV["REDISTOGO_URL"])
	if uri
		REDIS = Redis.new(:host => uri.host, :port => uri.port, :password => uri.password)
	else
		REDIS = Redis.new(:host => 'localhost', :port => 6379, :db => 0) 
	end
end
