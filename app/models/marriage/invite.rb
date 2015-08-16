class Marriage::Invite < ActiveRecord::Base
  belongs_to :marriage
  has_many :guests

  def start_code(length = 2)
    self.code = build_code(length) until unique_code?
    save
  end

  private

  def build_code(length)
    SecureRandom.hex(length)
  end

  def unique_code?
    !marriage.invites.where('id != ?', id).exists?(code: code) if code
  end
end
