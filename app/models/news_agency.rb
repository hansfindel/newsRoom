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
# http://api.nytimes.com/svc/mostpopular/v2/
# http://www.programmableweb.com/api/newsknowledge

class NewsAgency
  include Mongoid::Document
  field :name, type: String
  #if false, is a RSS Feed
  field :is_api, type: Boolean
  field :feed_url, type: String
  has_many :articles

  validates_presence_of :name, :feed_url, message: "must be present"
  validates_uniqueness_of :feed_url, message: "must be unique"
  
end
