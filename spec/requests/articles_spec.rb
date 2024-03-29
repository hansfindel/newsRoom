require 'spec_helper'
#require 'capybara/rspec' #required in spec_helper 

describe Article do
  before (:each) do
    #@current_user = build(:user)
    #current_user = @current_user
    #@current_user.save
    get log_out_path
  end

  describe "GET /articles" do
    it "get to index" do
      get articles_path
      response.status.should be(200)
    end
    it "displays not published articles in the not published area" do
      login_as_admin
      @article = build(:article)
      @article.is_published = false
	    prev_count = Article.where(is_published: false).count
	    @article.save
      #post_via_redirect articles_path, article: @article.attributes
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
      @article_pub = build(:article_pub)
      #@article.is_published = true
      prev_count = Article.all.count
	    @article_pub.save.should eq(true)
	    #headline = @article_pub.headline
      get articles_path
      post_count = Article.all.count
      (post_count > prev_count).should be_true
      #response.body.should include(headline)
    end
    it "does not display published articles in not published area" do
      @article = build(:article)
      @article.headline = "basdf"
      @article.is_published = true
	    @article.save.should eq(true)
	    headline = @article.headline
      login_as_admin
      get non_published_articles_path
      response.body.should_not include(headline)
    end
  end

  describe "post /articles" do # should be by every role: as journalist" do
    it "displays articles" do
      login_as_admin
      headline = "holo"
      prev_count = Article.all.count
      @article = Article.new({headline: headline, story: "story"})
      @article.save
      #post_via_redirect articles_path, article: @article.attributes
      #response.body.should include(headline)
      post_count = Article.all.count
      (post_count > prev_count).should be_true
      (Article.where(headline: headline).size > 0).should be_true
    end

    it "create through the form" do 
      login_as_admin
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
      login_as_admin
    	visit new_article_path
		  fill_in "article_story", :with => "ice"    	
      click_button "Create Article" #en este caso no tiene clase ni id, pero pesca lo que dice el boton
    	# save_and_open_page  #con esto puedes ver el estado de la pagina en el browser
    	page.should_not have_content("Article was successfully created.")
    	page.should have_content("Headline must be present")
   	end
  end

  #describe "form with js" do
  #	it "shows a no headline message", js: true do 
  #  	visit new_article_path
  #		fill_in "article_story", :with => "ice"    	
  #    	click_button "Create Article" #en este caso no tiene clase ni id, pero pesca lo que dice el boton
  #    	page.should_not have_content("Article was successfully created.")
  #    	page.should have_content("Headline must be present")   #message in the article model		
  #	end
  #end


end