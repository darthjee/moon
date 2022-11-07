# frozen_string_literal: true

module Marriage::Invite::List
  extend ActiveSupport::Concern

  include Marriage::Invite::Common

  def invites
    @invites ||= marriage.invites.created.where(filters).limit(per_page).offset(offset)
  end

  private

  def offset
    (params[:page].to_i - 1) * per_page
  end

  def per_page
    @per_page ||= (params[:per_page] || 10).to_i
  end

  def filters
    @filters ||= params.permit(:up_to_date, :status)
  end
end
