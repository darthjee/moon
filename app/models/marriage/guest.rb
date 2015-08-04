class Marriage::Guest < ActiveRecord::Base
  belongs_to :invite
  belongs_to :marriage

  scope :confirmed, proc { where(presence: true) }
  scope :search_name, proc { |name| where('name ILIKE ?', "%#{name}%") }
end
