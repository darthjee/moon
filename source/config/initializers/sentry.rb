Raven.configure do |config|
  config.dsn = "https://#{ENV['MOON_SENTRY_KEY']}:#{ENV['MOON_SENTRY_SECRET']}@sentry.io/#{ENV['MOON_SENTRY_ID']}"
end

