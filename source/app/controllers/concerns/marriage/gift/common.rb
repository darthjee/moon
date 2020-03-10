module Marriage::Gift::Common
  extend ActiveSupport::Concern

  include Marriage::Common

  def gift
    marriage.gifts.find(params[:id])
  end
end
