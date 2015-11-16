module Marriage::Invite::List
  extend ActiveSupport::Concern

  def invites
    @invites ||= marriage.invites.limit(per_page).offset(offset)
  end

  private

  def offset
    (params[:page].to_i - 1) * per_page
  end

  def per_page
    @per_page ||= (params[:per_page] || 10).to_i
  end
end
