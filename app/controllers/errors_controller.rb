class ErrorsController < ApplicationController
  skip_authorization_check
  layout false
  def overload
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: {} }
    end
  end
end