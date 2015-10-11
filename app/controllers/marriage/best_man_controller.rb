class Marriage::BestManController < ApplicationController
  include Marriage::Login

  def index
    respond_to do |format|
      format.json { render json: invite_from_credential_json }
      format.html { render :index }
    end
  end

  def show
    respond_to do |format|
      format.html { render :show }
    end
  end

  private

  def invite_from_credential_json
    invite_from_credential.as_json(include: :guests)
  end

  def invite
    marriage.invites.find_by(code: invite_code)
  end

  def invite_code
    params[:code]
  end
end
