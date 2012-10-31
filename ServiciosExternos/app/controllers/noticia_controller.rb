$NewsRoomApi = "http://localhost:3000/articles"

class NoticiaController < ApplicationController
  # GET /noticia
  # GET /noticia.json
  def index
    require 'open-uri'

    f = open("#$NewsRoomApi.json").read
    @json = JSON.parse(f)

  end

  # GET /noticia/1
  # GET /noticia/1.json
  def show
    require 'open-uri'
    f = open("#$NewsRoomApi/#{params[:id]}.json").read
    @json = JSON.parse(f)

  end

end
