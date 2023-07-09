# frozen_string_literal: true

class Settings
  extend Sinclair::EnvSettable

  settings_prefix 'MOON'

  with_settings(
    :password_salt,
    hex_code_size: 16,
    session_period: 2.days,
    cache_age: 10.seconds,
    title: 'Moon',
    favicon: '/favicon.ico'
  )
end
