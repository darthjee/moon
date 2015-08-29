module Marriage::Common
  extend ActiveSupport::Concern
  include Marriage::Redirector

  included do
    helper_method :marriage
    layout :layout_for_page
    redirection_rule :perform_angular_redirect?
    skip_redirection_rule :is_ajax?, :is_home?
  end

  private

  def layout_for_page
    is_ajax? ? false : 'marriage'
  end

  def marriage
    @marriage ||= Marriage::Marriage.first
  end

  def is_ajax?
    params[:ajax]
  end

  def perform_angular_redirect?
    request.format.html?
  end

  def is_home?
    request.path == '/'
  end
end
