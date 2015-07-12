module Marriage::Common
  extend ActiveSupport::Concern

  included do
    helper_method :marriage
    layout 'marriage'
  end

  private

  def marriage
    @marriage ||= Marriage::Marriage.first
  end
end
