require File.dirname(__FILE__) + '/../spec_helper'

describe "ArticleCategory" do
	before :each do
		@article = build(:article_pub)
		@article.save
		@category = build(:category)
		@category.save
	end

	describe "#construct" do
	    it "requires one valid object of each" do
	    	(ArticleCategory.construct(@article, @category)).should be_true
	    end
	    it "works with one article and a category name" do 
	    	prev = Category.all.count
	    	(ArticleCategory.construct(@article, "arte #{@article.id}")).should be_true
	    	post = Category.all.count
	    	(post > prev).should be_true #the category should be created
	    end
	    it "does recibe a valid unsaved article and creates it" do
	    	@article2 = build(:article)
	    	(ArticleCategory.construct(@article2, @category)).should be_true
	    	@article2.id.should_not be_nil
	    end
	end

	describe "#construct that should fail" do
	    it "does not recibe a valid article" do
	    	(ArticleCategory.construct(@article.headline, @category)).should be_false
	    end
	    it "does recibe an article headline and a category name" do 
	    	(ArticleCategory.construct(@article.headline, "artes #{@article.id}")).should be_false
	    end
	    it "recibes de values in the wrong order" do 
	    	(ArticleCategory.construct("inverse #{@article.id}", @article)).should be_false
	    end
	end	

end