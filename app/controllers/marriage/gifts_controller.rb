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
    marriage.gifts.limit(per_page).offset(offset)
  end

  private

  def offset
    (params[:page].to_i - 1) * per_page
  end

  def per_page
    @per_page ||= (params[:per_page] || 10).to_i
  end
end
