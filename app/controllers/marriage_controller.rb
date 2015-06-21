class MarriageController < ApplicationController
  def show
    render :show, locals: {
      marriage: marriage
    }
  end

  private

  def marriage
    @marriage ||= Marriage::Marriage.first
  end
end
