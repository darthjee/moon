# frozen_string_literal: true

module Marriage
  class Invite < ActiveRecord::Base
    module Update
      extend ActiveSupport::Concern

      include ::Marriage::Invite::Common
      include ::Marriage::Services

      private

      def check_valid_update
        if invite_updater.valid?
          invite_updater.save
        else
          render json: { errors: invite_errors }, status: :unprocessable_entity
        end
      end

      def invite_updater
        @invite_updater ||= Invite::Updater.new(invite, user, params)
      end

      def user
        @user ||= User.for_invite(invite)
      end

      def invite_errors
        invite.errors.messages.merge(
          user: invite.user.errors.messages
        )
      end
    end
  end
end
