class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.json
  load_and_authorize_resource
  #skip_before_filter :verify_authenticity_token, :only => [:update,:create]
  def index
    #@articles = #Article.where(:is_published => true)
    @articles = Article.published.paginated(params[:page])
    respond_to do |format|

      format.html # index.html.erb
      format.json { render json: @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.json
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @article }
    end
  end

  # GET /articles/1/edit
  def edit
    @article = Article.find(params[:id])
    
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(params[:article])
    @article.set_initial_grades
    if current_role.include?('journalist')
      @article.user = current_user
      @article.country = current_user.country
    end
    respond_to do |format|
      if @article.save
        @article.add_picture(params[:picture])
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render json: @article, status: :created, location: @article }
      else
        format.html { render action: "new" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.json
  def update
    @article = Article.find(params[:id])
    if params[:tags]
      @article.category_names=(params[:tags].split(","))
      ArticleCategory.where(:article_id => @article.id).destroy_all
    end
    respond_to do |format|
      if @article.update_attributes(params[:article])

        if(current_role.include?('editor') || current_role.include?('chief_editor') || current_role.include?('chief_editor_country'))
          @article.add_grade
        end

        format.html { redirect_to :back, notice: 'Article was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end

    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url }
      format.json { head :no_content }
    end
  end

  def fetch_and_store
    Glutton.fetch_and_store
    redirect_to articles_path, notice: "New feeds were fetched and processed"
  end
  def process_feeds
    FeedProcessor.process_feeds
    redirect_to articles_path, notice: "New feeds were processed"
  end
  
  def show_non_published
    if current_user
      @articles = Article.where(:is_published => false, :editors_grade =>0)#, :country => current_user_country, :area => current_user_area) #, :user_id.ne => current_user_id
    else
      @articles = Article.where(:is_published => false, :editors_grade =>0) #, :user_id.ne => current_user_id
    end
    @news = Article.nonpublished.where(:area.exists => false).limit(5)
    @country = current_user_country

    respond_to do |format|
      format.html
      format.json { render json: @articles }
    end
  end

  def chief_editors_non_published
    if current_user
      @articles = Article.where(:is_published => false, :chief_editor_grade =>0, :editors_grade.gt => 0) #, :country => current_user_country, :area => current_user_area) #, :user_id.ne => current_user_id
    else
      @articles = Article.where(:is_published => false, :chief_editor_grade =>0) #, :user_id.ne => current_user_id
    end

    respond_to do |format|
      format.html { render :template => "articles/show_non_published" }
      format.json { render json: @articles }
    end
  end

  def chief_editors_country_non_published
    @articles = Article.nonpublished.where(:chief_editor_country_grade =>0, :editors_grade.ne =>0, :chief_editor_grade.ne =>0,:user_id.ne => current_user_id, :country => current_user_country)

    respond_to do |format|
      format.html { render :template => "articles/show_non_published" } 
      format.json { render json: @articles }
    end
  end
end
