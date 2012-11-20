# feed warehouses uri
# http://feed.dilbert.com/dilbert/daily_strip
# http://feeds.feedburner.com/railscasts
# http://www.infoq.com/rss/rss.action?token=VfxWqMTa4WzLcugRMN9W4IINk7k5x7OK
# http://www.microsiervos.com/index.xml
# http://feeds.mashable.com/mashable
# http://alt1040.com/feed

# http://feeds.feedburner.com/montt

# web api 
# http://developer.nytimes.com/
# http://newsknowledge.com/api/rest.html  
# http://api.nytimes.com/svc/search/v1/article?query=international&api-key=06f2570a8924f348a75333c2d3bbad0d:6:66959080
# http://www.programmableweb.com/api/newsknowledge

class NewsAgency
  include Mongoid::Document
  field :name, type: String
  #if false, is a RSS Feed
  field :is_api, type: Boolean, :default => false
  field :feed_url, type: String
  #contains the equivalent of article properties to help fetching
  field :api_values, type: Hash

  has_many :articles

  validates_presence_of :name, :feed_url, message: "must be present"
  validates_uniqueness_of :feed_url, message: "must be unique"
  validates_presence_of :api_values, :if => :is_api?
  
end
