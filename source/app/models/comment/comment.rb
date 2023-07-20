# frozen_string_literal: true

module Comment
  class Comment < ApplicationRecord
    belongs_to :thread
    belongs_to :user, class_name: 'User'

    default_scope do
      order(id: :desc)
    end

    def as_json(*args)
      super(*args).merge(
        user: user.as_json,
        time_elapsed: time_elapsed.as_json
      )
    end

    private

    def time_elapsed
      Utils::TimeElapsed.new(created_at)
    end
  end
end
