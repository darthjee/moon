# frozen_string_literal: true

class Comment::Thread < ActiveRecord::Base
  has_many :comments
  belongs_to :marriage, class_name: 'Marriage::Marriage'
end
