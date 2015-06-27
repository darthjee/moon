class MarriageController < ApplicationController
  helper_method :marriage

  def show
    render :show
  end

  private

  def marriage
    @marriage ||= Marriage::Marriage.first
  end
end
