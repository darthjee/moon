class Marriage::Invite < ActiveRecord::Base
  belongs_to :marriage
  has_many :guests

  def start_code
    self.code = build_code until unique_code?
    save
  end

  def build_code
    SecureRandom.hex(5)
  end

  def unique_code?
    !marriage.invites.exists?(code: code)
  end
end
