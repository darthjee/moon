class Marriage::Invite < ActiveRecord::Base
  belongs_to :marriage
  has_many :guests
  before_create :start_codesss

  validates :email, email: true, if: -> { email.present? }

  scope :search_label, proc { |label| where('label ILIKE ?', "%#{label}%") }

  def start_code(length = 2)
    start_random_attribute(:code, length)
    save
  end

  def start_authentication_token(length = 8)
    start_random_attribute(:authentication_token, length)
    save
  end

  private

  def start_random_attribute(attribute, length)
    public_send("#{attribute}=", build_code(length)) until unique_attribute?(attribute, public_send(attribute))
  end

  def build_code(length)
    SecureRandom.hex(length)
  end

  def unique_code?
    unique_attribute?(:code, code)
  end

  def unique_token?
    unique_attribute?(:authentication_token, authentication_token)
  end

  def unique_attribute?(key, value)
    !other_invites.exists?(key => value) if value
  end

  def other_invites
    marriage.invites.where('id != ?', id)
  end

  def start_codesss
    start_random_attribute(:code, 2)
    start_random_attribute(:authentication_token, 8)
  end
end
