# frozen_string_literal: true

class Marriage::MarriageController < ApplicationController
  include Marriage::Common

  def show
    render :show
  end
end
