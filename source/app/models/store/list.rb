# frozen_string_literal: true

class Store::List < ActiveRecord::Base
  belongs_to :marriage, class_name: 'Marriage::Marriage'
  belongs_to :store
  has_many :gift_links, class_name: 'Marriage::GiftLink', foreign_key: :store_list_id
end
