class MarriageController < ApplicationController
  include Marriage::Common

  def show
    render :show
  end
end
