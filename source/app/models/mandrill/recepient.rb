# frozen_string_literal: true

module Mandrill
  class Recepient < DelegateClass(RecursiveOpenStruct)
    def initialize(recepient)
      @recepient = if recepient.is_a?(Hash)
                     RecursiveOpenStruct.new(recepient)
                   else
                     recepient
                   end

      super(@recepient)
    end

    def allowed?
      Mandrill.email_allowed? email
    end
  end
end
