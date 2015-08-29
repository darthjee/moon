module Marriage::Common
  extend ActiveSupport::Concern
  include Marriage::Redirector

  included do
    helper_method :marriage
    layout :layout_for_page
    redirection_rule :perform_angular_redirect?
  end

  private

  def layout_for_page
    params[:ajax] ? false : 'marriage'
  end

  def marriage
    @marriage ||= Marriage::Marriage.first
  end

  def perform_angular_redirect?
    request.format.html? && !is_home?
  end

  def is_home?
    request.path == '/'
  end
end
