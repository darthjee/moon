# frozen_string_literal: true

module Marriage
  class MarriageController < ApplicationController
    include ::Marriage::Common

    def show
      render :show
    end
  end
end
