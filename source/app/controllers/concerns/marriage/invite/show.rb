# frozen_string_literal: true

module Marriage
  class Invite < ApplicationRecord
    module Show
      extend ActiveSupport::Concern

      include ::Marriage::Invite::Common

      def show_json_invite
        invite.update(last_view_date: Time.zone.now)
        render json: invite.as_json(include: %i[guests user])
      end

      def show_png_invite
        render text: show_path_qr_code
      end

      private

      def show_path_qr_code
        QRCodeBuilder.new(show_path, 'public/icon.png').build
      end

      def show_path
        show_marriage_invites_url(
          invite.code, token: invite.user.authentication_token
        )
      end
    end
  end
end
