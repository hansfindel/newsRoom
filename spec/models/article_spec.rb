require File.dirname(__FILE__) + '/../spec_helper'

describe Article do
	before :each do
		Article.destroy_all
		User.destroy_all
		@article = Article.new
	end

	describe "#new" do
	    it "takes no parameters and returns an Article object" do
	        @article.should be_an_instance_of Article
	    end
	end

	describe "test the validations" do
		it "cannot be saved, it has no headline" do 
			@article.save.should be_false
		end

		it "it should be saved" do 
			@article.headline = "uniq"
			@article.save.should be_true
		end
		it "it should be saved should be not published" do 
			@article.headline = "un1q"
			@article.save.should be_true
			@article.is_published.should be_false
		end
		it "it should be saved should be published if it was set so" do 
			@article.headline = "un1q"
			@article.is_published = true
			@article.save.should be_true
			@article.is_published.should be_true
		end
	end


	describe "#article can be updated" do
		it "update article" do
			@article.headline = "unique"
			@article.save.should be_true
			@article.new_record?.should be_false
			@article.deck = "it is an article"
			@article.save.should be_true
		end 
		it "should update grade when editors grade it" do 
			@article.headline = "new_article_1"
			@article.save.should be_true
			@article.new_record?.should be_false
			@article.editors_grade = 5
			@article.add_grade #.should be_true
			(@article.grade > 4).should be_true
			@article.chief_editor_grade = 6
			@article.add_grade #.should be_true
			(@article.grade > 10) #.should be_true			
			@article.chief_editor_country_grade = 7
			@article.add_grade.should be_true
			@article.is_published.should be_true			
		end
		it "gets published when well graded" do 
			@article.headline = "un1que"
			@article.save.should be_true
			@article.new_record?.should be_false
			@article.editors_grade = 16
			@article.add_grade.should be_true
			(@article.grade > 15).should be_true
			@article.is_published.should be_true
		end
		it "gets it's own guid" do
			@article.headline = "asdf"
			@article.save
			@article.guid.should_not be_nil
		end
		it "categorize the category array" do
			Category.destroy_all
			@article.headline = "asdfqwer"
			@article.category_names = ["1", "2", "3"]
			@article.save
			(Category.count > 0).should be_true
		end
		it "user can create article" do
			@user = build(:user)
			@user.save.should be_true
			article = @user.articles.build(headline: "user_article")
			article.save.should be_true
		end
		it "returns its user's name" do
			@user = build(:user)
			@user.save.should be_true
			article = @user.articles.build(headline: "user_article1")
			article.save.should be_true
			article.user_name.should eq(@user.name)
		end
		it "returns user_name=nil if it has no user" do
			article = build(:article, headline: "no_user_article1")
			article.save.should be_true
			article.user_name.should eq("")
		end
    end

end