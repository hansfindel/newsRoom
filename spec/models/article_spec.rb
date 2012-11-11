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

	describe "test the validations" do
		it "cannot be saved, it has no headline" do 
			@article.save.should == false
		end

		it "it should be saved" do 
			@article.headline = "uniq"
			@article.save.should eq(true)
		end
		#it "should test uniqueness of url"
	end


	describe "#article can be updated" do
		it "update article" do
			@article.headline = "unique"
			@article.save.should eq(true)
			@article.new_record?.should eq(false)
			@article.deck = "it is an article"
			@article.save.should eq(true)
		end 
    end

end