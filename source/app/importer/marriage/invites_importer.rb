# frozen_string_literal: true

require 'csv'

module Marriage
  class InvitesImporter
    attr_accessor :file, :marriage_id

    def initialize(file, marriage_id)
      @file = file
      @marriage_id = marriage_id
    end

    def import
      file.each do |line|
        args = CSV.parse(line).flatten
        create_invite(*args).start_code
      end
    end

    private

    def create_invite(label, invites, expected)
      marriage.invites.create(
        label:,
        invites:,
        expected:
      )
    end

    def marriage
      Marriage::Marriage.find(marriage_id)
    end
  end
end
