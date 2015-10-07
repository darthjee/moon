module Marriage::Login
  extend ActiveSupport::Concern
  include Marriage::Common

  private

  def login_required
    return if is_logged?
    redirect_to login_path
  end

  def login_path
    marriage_login_index_path(redirection_param)
  end

  def redirection_param
    path = request.path
    query = request.query_parameters.to_query
    { redirect_to: "#{path}?#{query}" }.merge ajax: params[:ajax]
  end

  def is_logged?
    invite_from_credential.present?
  end

  def credential
    @credential ||= cookies.signed[:credentials]
  end

  def invite_from_credential
    return unless credential.present?
    @invite_from_credential ||= find_invite_from_credential
  end

  def find_invite_from_credential
    marriage.invites.find_by(authentication_token: credential)
  end
end