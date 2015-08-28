module Marriage::Common
  extend ActiveSupport::Concern
  include Marriage::Redirector

  included do
    helper_method :marriage
    layout :layout_for_page
  end

  private

  def layout_for_page
    params[:ajax] ? false : 'marriage'
  end

  def marriage
    @marriage ||= Marriage::Marriage.first
  end
end
