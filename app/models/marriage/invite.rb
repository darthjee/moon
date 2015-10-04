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
    public_send("#{attribute}=", build_code(length)) until unique_attribute?(attribute)
  end

  def build_code(length)
    SecureRandom.hex(length)
  end

  def unique_attribute?(attribute)
    value = public_send(attribute)
    !other_invites.exists?(attribute => value) if value
  end

  def other_invites
    marriage.invites.where('id != ?', id)
  end

  def start_codesss
    start_random_attribute(:code, 2)
    start_random_attribute(:authentication_token, 8)
  end
end
