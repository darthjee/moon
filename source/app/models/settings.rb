# frozen_string_literal: true

# Class responsible for general application settings
class Settings
  extend Sinclair::EnvSettable

  settings_prefix 'MOON'

  with_settings(
    :password_salt,
    default_pagination_size: 8
  )
end
