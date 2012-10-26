class NoticiaController < ApplicationController
  # GET /noticia
  # GET /noticia.json
  def index
    @noticia = Noticium.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @noticia }
    end
  end

  # GET /noticia/1
  # GET /noticia/1.json
  def show
    @noticium = Noticium.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @noticium }
    end
  end

  # GET /noticia/new
  # GET /noticia/new.json
  def new
    @noticium = Noticium.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @noticium }
    end
  end

  # GET /noticia/1/edit
  def edit
    @noticium = Noticium.find(params[:id])
  end

  # POST /noticia
  # POST /noticia.json
  def create
    @noticium = Noticium.new(params[:noticium])

    respond_to do |format|
      if @noticium.save
        format.html { redirect_to @noticium, notice: 'Noticium was successfully created.' }
        format.json { render json: @noticium, status: :created, location: @noticium }
      else
        format.html { render action: "new" }
        format.json { render json: @noticium.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /noticia/1
  # PUT /noticia/1.json
  def update
    @noticium = Noticium.find(params[:id])

    respond_to do |format|
      if @noticium.update_attributes(params[:noticium])
        format.html { redirect_to @noticium, notice: 'Noticium was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @noticium.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /noticia/1
  # DELETE /noticia/1.json
  def destroy
    @noticium = Noticium.find(params[:id])
    @noticium.destroy

    respond_to do |format|
      format.html { redirect_to noticia_url }
      format.json { head :no_content }
    end
  end
end
