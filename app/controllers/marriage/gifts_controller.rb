class Marriage::GiftsController < ApplicationController
  include Marriage::Common

  def index
    respond_to do |format|
      format.json { render json: gifts_json }
      format.html { render :index }
    end
  end

  private

  def gifts_json
    gifts.as_json
  end

  def gifts
    marriage.gifts
  end
end
