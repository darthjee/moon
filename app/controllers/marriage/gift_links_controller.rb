class Marriage::GiftLinksController < ApplicationController
  include Marriage::Common

  def show
    respond_to do |format|
      format.json { render json: gift_link_json }
      format.html { cached_render :show }
    end
  end

  private

  def gift_link_json
    gift_link.as_json(include: :gift)
  end

  def gift_link
    Marriage::GiftLink.find(link_id).as_json(include: :gift)
  end

  def link_id
    params.require(:id)
  end
end
