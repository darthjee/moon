class Marriage::EventsController < ApplicationController
  include Marriage::Common

  def index
    render_basic
  end

  def maps
  end

  private

  def index_json
    events.as_json
  end

  def events
    marriage.events
  end
end

