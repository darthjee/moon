module FixtureHelpers
  def load_fixture_file(filename)
    FixtureHelpers.fixture_file_cache["#{filename}"] ||=
      Rails.root.join('spec', 'fixtures', filename).read
  end

  def load_json_fixture_file(filename)
    FixtureHelpers.json_fixture_file_cache["#{filename}"] ||=
      ActiveSupport::JSON.decode(load_fixture_file(filename))
  end

  def self.fixture_file_cache
    @fixture_file_cache ||= {}
  end

  def self.json_fixture_file_cache
    @json_fixture_file_cache ||= {}
  end
end

RSpec.configuration.include FixtureHelpers
