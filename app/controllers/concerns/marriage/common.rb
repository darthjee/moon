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
    redirect_to "##{request.path}" if request.format == :html && request.path != '/'
  end

  def layout_for_page
    params[:ajax] ? false : 'marriage'
  end

  def marriage
    @marriage ||= Marriage::Marriage.first
  end
end
