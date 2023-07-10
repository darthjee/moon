# frozen_string_literal: true

class User < ActiveRecord::Base
  has_one :invite, class_name: 'Marriage::Invite', foreign_key: :user_id
  before_create :start_codesss

  validates :email, email: true, if: -> { email.present? }

  scope(:authenticated, -> { where.not(authentication_token: nil) })
  scope(:with_login, -> { where.not(email: nil, password: nil) })

  class << self
    def for_invite(invite)
      invite.user
    end

    def login(email, password)
      User.find_by!(email: email).verify_password!(password)
    rescue ActiveRecord::RecordNotFound
      raise Moon::Exception::LoginFailed
    end
  end

  def password=(pass)
    self.salt = SecureRandom.hex

    super(encrypt(pass))
    self.encrypted_password = self.password
  end

  def verify_password!(pass)
    return self if encrypted_password == encrypt(pass)

    raise Moon::Exception::LoginFailed
  end

  def start_code(length = 2)
    start_random_attribute(:code, length)
    save
  end

  def start_authentication_token(length = 8)
    start_random_attribute(:authentication_token, length)
    save
  end

  private

  def encrypt(pass)
    return unless pass.present?

    plain = salt + pass# + Settings.password_salt

    Digest::SHA256.hexdigest(plain)
  end

  def start_codesss
    start_random_attribute(:code, 2)
    start_random_attribute(:authentication_token, 8)
  end

  def start_random_attribute(attribute, length)
    until unique_attribute?(attribute)
      public_send("#{attribute}=", build_code(length))
    end
  end

  def build_code(length)
    SecureRandom.hex(length)
  end

  def unique_attribute?(attribute)
    value = public_send(attribute)
    !other_users.exists?(attribute => value) if value
  end

  def other_users
    self.class.where('id != ?', id)
  end
end
