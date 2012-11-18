require File.dirname(__FILE__) + '/../spec_helper'

describe Glutton do
	before :each do
		NewsAgency.destroy_all
		Article.destroy_all
		@ups = NewsAgency.new(name: "UPS", feed_url: "http://feeds.feedburner.com/railscasts")
		if !@ups.save
			@ups = NewsAgency.where(name: "UPS").first
		end
		@reuters  = NewsAgency.new(name: "Reuters", feed_url: "http://feeds.mashable.com/mashable")
		if !@reuters.save
			@reuters = NewsAgency.where(name: "Reuters").first
		end
		@glutton = Glutton.new
	end

	describe "#new" do
	    it "takes no parameters and returns an User object" do
	        @glutton.should be_an_instance_of Glutton
	    end

	    it "fetches news for every news agency available" do
	    	(NewsAgency.all.count > 0).should be_true
	    	Glutton.fetch.should be_true
	    end

	    it "fetches news for one news agency" do
	    	Glutton.update_from_feed("http://www.microsiervos.com/index.xml").should be_true
	    end

	    it "generates new articles" do
	    	Glutton.fetch_and_store
	    	(Article.count>0).should be_true
	    end	    

	end
end