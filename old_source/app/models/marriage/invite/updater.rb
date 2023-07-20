# frozen_string_literal: true

module Marriage
  class Invite < ActiveRecord::Base
    class Updater
      attr_reader :invite, :user, :params

      delegate :valid?, :save, to: :invite

      def initialize(invite, user, params)
        @invite = invite
        @user = user
        @params = params

        invite.user.assign_attributes(user_update_params)
      end

      def update
        update_invite_guests
        create_invite_guests
        update_user
        remove_guests
        invite.update(confirmed: invite.guests.confirmed.count)
      end

      private

      def update_invite_guests
        guests_update_params.each do |guest_params|
          guest = invite.guests.find(guest_params[:id])
          guest.update(guest_params)
        end
      end

      def update_user
        return if user.name.present?

        user.update(name: invite.guests.first.try(:name))
      end

      def create_invite_guests
        new_guests_params.each do |guest_params|
          attributes = guest_params.merge(invite: invite)
          ::Marriage::Guest.create(attributes)
        end
      end

      def remove_guests
        invite.guests.where(id: removed_guests_id).update_all(active: false)
      end

      def guests_update_params
        guests_params.select { |g| g[:id].present? }
      end

      def guests_params
        invite_params[:guests] || []
      end

      def user_update_params
        invite_params[:user]
      end

      def new_guests_params
        guests_params.select { |g| g[:id].blank? && g[:name].present? }
      end

      def invite_params
        @invite_params ||= fetch_invite_params
      end

      def removed_guests_id
        params[:removed]
      end

      def fetch_invite_params
        params
          .require(:invite)
          .permit(:removed, guests: %i[id name presence], user: :email)
      end
    end
  end
end
