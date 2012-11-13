require 'spec_helper'
require 'capybara/rspec'

describe Article do
  before (:each) do
    #@current_user = build(:user)
    #current_user = @current_user
    #@current_user.save
  end

  describe "GET /articles" do
    it "get to index" do
      get articles_path
      response.status.should be(200)
    end
    it "displays not published articles in the not published area" do
      @article = build(:article)
      @article.is_published = false
      #user = build(:user)
      #user.save.should be_true
      #@article.save.should eq(true)
	  prev_count = Article.where(is_published: false).count
	  post_via_redirect articles_path, article: @article.attributes
	  post_count = Article.where(is_published: false).count
	  (post_count > prev_count).should be_true
    end

    it "does not display not published articles in the published area" do
      @article = build(:article)
      @article.headline = "my headline is not displayed in published areas"
      @article.is_published = false
	  @article.save.should eq(true)
	  headline = @article.headline
      get articles_path
      response.body.should_not include(headline)
    end

   	it "displays published articles in published area" do
      @article = build(:article)
      @article.is_published = true
	  @article.save.should eq(true)
	  headline = @article.headline
      get articles_path
      response.body.should include(headline)
    end
    it "does not display published articles in not published area" do
      @article = build(:article)
      @article.headline = "basdf"
      @article.is_published = true
	  @article.save.should eq(true)
	  headline = @article.headline
      get non_published_articles_path
      response.body.should_not include(headline)
    end
  end

  describe "post /articles" do # should be by every role: as journalist" do
    it "displays articles" do
      headline = "holo"
      prev_count = Article.all.count
      post_via_redirect articles_path, article: {headline: headline, story: "story"}
      response.body.should include(headline)
      post_count = Article.all.count
      (post_count > prev_count).should be_true
      (Article.where(headline: headline).size > 0).should be_true
    end

    it "create through the form" do 
    	visit new_article_path
    	fill_in "article_headline", :with => "fire"  #article_headline es el id en el form para poner el headline
		fill_in "article_story", :with => "here"    	
      	click_button "Create Article" #en este caso no tiene clase ni id, pero pesca lo que dice el boton
      	# save_and_open_page  #con esto puedes ver el estado de la pagina en el browser
      	page.should have_content("Article was successfully created.")
      	page.should have_content("fire")
      	page.should have_content("here")
   	end

   	it "cant create through the form (no headline)" do 
    	visit new_article_path
		fill_in "article_story", :with => "ice"    	
      	click_button "Create Article" #en este caso no tiene clase ni id, pero pesca lo que dice el boton
      	# save_and_open_page  #con esto puedes ver el estado de la pagina en el browser
      	page.should_not have_content("Article was successfully created.")
      	page.should_not have_content("ice")
   	end
  end
end