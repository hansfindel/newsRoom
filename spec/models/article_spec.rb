require File.dirname(__FILE__) + '/../spec_helper'

describe Article do
	before :each do
	@article = Article.new
	end

	describe "#new" do
	    it "takes no parameters and returns an Article object" do
	        @article.should be_an_instance_of Article
	    end
	end

	describe "#add_grade" do
		it "update article's grade" 
    end

end