class Marriage::Invite < ActiveRecord::Base
  belongs_to :marriage
  has_many :guests
  belongs_to :user, class_name: 'User'

  validates :email, email: true, if: -> { email.present? }

  scope :search_label, proc { |label| where('label ILIKE ?', "%#{label}%") }
  scope :created, proc { where(status: :created) }
  default_scope { where.not(status: :cancelled) }

end
