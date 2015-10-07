class Marriage::BestManController < ApplicationController
  include Marriage::Login

  before_action :login_required

  def index
  end

  def show
    respond_to do |format|
      format.html { render :show }
    end
  end

  private

  def invite
    marriage.invites.find_by(code: invite_code)
  end

  def invite_code
    params[:code]
  end
end
