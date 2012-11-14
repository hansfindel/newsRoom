require 'feedzirra'

class Glutton
  #this crawls through each news_agency
  def self.fetch
  	@value ||= []
  	NewsAgency.all.each do |agency|
  		feed = Feedzirra::Feed.fetch_and_parse(agency.feed_url)
  		@value = RawData.store(feed, @value)
  	end
  	@value	
  end
  def self.fetch_and_store
    NewsAgency.all.each do |agency|
      feed = Feedzirra::Feed.fetch_and_parse(agency.feed_url)
      @value = RawData.store(feed)
      FeedProcessor.process_feeds(@value)
    end
  end

  #if called for each feed_url
  def self.update_from_feed(feed_url)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    RawData.store(feed)
    #add_entries(feed.entries)
  end  

  #if running with cron...
  def self.update_from_feed_continuously(feed_url, delay_interval = 15.minutes)
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)
    add_entries(feed.entries)
    loop do
      sleep delay_interval
      feed = Feedzirra::Feed.update(feed)
      #add_entries(feed.new_entries) if feed.updated?
      RawData.store(feed.new_entries) if feed.updated?
    end
  end

end
