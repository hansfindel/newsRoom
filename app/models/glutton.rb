require 'feedzirra'
require 'open-uri'
require 'json'

class Glutton
  #this crawls through each news_agency
  def self.fetch
  	@value ||= []
  	NewsAgency.all.each do |agency|
      if !agency.is_api
  		  #feed = Feedzirra::Feed.fetch_and_parse(agency.feed_url)
        feed = Feedzirra::Feed.fetch_and_parse(agency)
        #@value = RawData.store(feed, @value)
      else
        feed = JSON.parse(open(agency.feed_url).read)
        #@value = RawData.store_from_api(feed, @value, agency.api_values)
      end
  		true
  	end
  	@value	
  end
  def self.fetch_and_store
    NewsAgency.all.each do |agency|
      if !agency.is_api
        feed = Feedzirra::Feed.fetch_and_parse(agency.feed_url)
        FeedProcessor.process_feeds(feed)
        #feed = Feedzirra::Feed.fetch_and_parse(agency.feed_url)
        #FeedProcessor.add_entries(feed.entries)
        #@value = RawData.store(feed)
      else
        #feed = JSON.parse(open(agency.feed_url).read)
        #FeedProcessor.add_entries_from_api(feed, agency.api_values, agency.api_values['results'])
        #@value = RawData.store_from_api(feed, agency.api_values, agency.api_values['results'])
      end
      true
    end
  end

  #if called for each feed_url
  def self.update_from_feed(agency, feed_url)
    if !agency.is_api
        feed = Feedzirra::Feed.fetch_and_parse(agency.feed_url)
    end
    RawData.store(feed)
    true
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
