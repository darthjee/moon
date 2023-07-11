# frozen_string_literal: true

module Marriage
  class Picture < ApplicationRecord
    belongs_to :album

    scope(:displayable, proc { where.not(status: :cancelled) })
    default_scope { displayable }
  end
end
