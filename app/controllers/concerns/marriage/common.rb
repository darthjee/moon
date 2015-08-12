module Marriage::Common
  extend ActiveSupport::Concern

  included do
    helper_method :marriage
    layout :layout_for_page
    before_action :render_root
  end

  private

  def render_root
    return if params[:ajax]
    redirect_to "##{request.path}" if perform_angular_redirect?
  end

  def perform_angular_redirect?
    request.format.html? && !is_home?
  end

  def is_home?
    request.path == '/'
  end

  def layout_for_page
    params[:ajax] ? false : 'marriage'
  end

  def marriage
    @marriage ||= Marriage::Marriage.first
  end
end
