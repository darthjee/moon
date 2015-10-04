class Marriage::Invite < ActiveRecord::Base
  belongs_to :marriage
  has_many :guests

  validates :email, email: true, if: -> { email.present? }

  scope :search_label, proc { |label| where('label ILIKE ?', "%#{label}%") }

  def start_code(length = 2)
    self.code = build_code(length) until unique_code?
    save
  end

  def start_authentication_token(length = 8)
    self.authentication_token = build_code(length) until unique_token?
    save
  end

  private

  def build_code(length)
    SecureRandom.hex(length)
  end

  def unique_code?
    other_like?(:code, code)
  end

  def unique_token?
    other_like?(:authentication_token, authentication_token)
  end

  def other_like?(key, value)
    other_invites.exists?(key => value) if value
  end

  def other_invites
    !marriage.invites.where('id != ?', id)
  end
end
