# frozen_string_literal: true

class EnvSettings
  extend Sinclair::EnvSettable

  settings_prefix 'MOON'

  with_settings(
    :password_salt,
    :default_pagination_size,
    :cache_age,
    :title,
    :favicon
  )
end
