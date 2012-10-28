class NewsAgenciesController < ApplicationController
  # GET /news_agencies
  # GET /news_agencies.json
  def index
    @news_agencies = NewsAgency.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @news_agencies }
    end
  end

  # GET /news_agencies/1
  # GET /news_agencies/1.json
  def show
    @news_agency = NewsAgency.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @news_agency }
    end
  end

  # GET /news_agencies/new
  # GET /news_agencies/new.json
  def new
    @news_agency = NewsAgency.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @news_agency }
    end
  end

  # GET /news_agencies/1/edit
  def edit
    @news_agency = NewsAgency.find(params[:id])
  end

  # POST /news_agencies
  # POST /news_agencies.json
  def create
    @news_agency = NewsAgency.new(params[:news_agency])

    respond_to do |format|
      if @news_agency.save
        format.html { redirect_to @news_agency, notice: 'News agency was successfully created.' }
        format.json { render json: @news_agency, status: :created, location: @news_agency }
      else
        format.html { render action: "new" }
        format.json { render json: @news_agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /news_agencies/1
  # PUT /news_agencies/1.json
  def update
    @news_agency = NewsAgency.find(params[:id])

    respond_to do |format|
      if @news_agency.update_attributes(params[:news_agency])
        format.html { redirect_to @news_agency, notice: 'News agency was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @news_agency.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /news_agencies/1
  # DELETE /news_agencies/1.json
  def destroy
    @news_agency = NewsAgency.find(params[:id])
    @news_agency.destroy

    respond_to do |format|
      format.html { redirect_to news_agencies_url }
      format.json { head :no_content }
    end
  end
end
