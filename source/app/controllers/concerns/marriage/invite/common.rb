# frozen_string_literal: true

module Marriage
  class Invite < ApplicationRecord
    module Common
      extend ActiveSupport::Concern

      include ::Marriage::Common

      def invite
        @invite ||= find_invite
      end

      private

      def find_invite
        return invite_by_id if invite_id

        invite_code ? invite_by_code : guest_invite
      end

      def invite_by_id
        ::Marriage::Invite.find(invite_id)
      end

      def invite_by_code
        User.find_by(code: invite_code).invite
      end

      def invite_id
        params[:id]
      end

      def invite_code
        params[:code]
      end

      def guest_invite
        guest.invite
      end

      def guest
        marriage.guests.find(guest_id)
      end

      def guest_id
        params[:guest_id]
      end
    end
  end
end
