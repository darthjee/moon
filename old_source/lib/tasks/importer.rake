# frozen_string_literal: true

namespace :import do
  desc 'Loads a CSV list of invites into a marriage'
  task :invite, %i[input marriage_id] => [:environment] do |_, args|
    fname = args[:input]
    marriage_id = args[:marriage_id] || 1

    begin
      raise 'Mandatory input file' unless fname

      file = File.open(fname, 'r')

      Marriage::InvitesImporter.new(file, marriage_id).import
    end
  end
end
