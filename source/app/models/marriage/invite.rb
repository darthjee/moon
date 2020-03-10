class Marriage::Invite < ActiveRecord::Base
  belongs_to :marriage
  has_many :guests
  belongs_to :user, class_name: 'User'

  validates_associated :user

  scope :search_label, proc { |label| where('label ILIKE ?', "%#{label}%") }
  scope :created, proc { where(status: :created) }
  default_scope { where.not(status: :cancelled) }

  accepts_nested_attributes_for :user

  #delegate :code, :authentication_token, :email, :name, to: :user

end
