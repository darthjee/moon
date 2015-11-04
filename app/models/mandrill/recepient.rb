class Mandrill::Recepient < DelegateClass(RecursiveOpenStruct)
  def initialize(recepient)
    @recepient = recepient.is_a?(Hash) ? RecursiveOpenStruct.new(recepient) : recepient
    super(@recepient)
  end

  def allowed?
    Mandrill.email_allowed? email
  end
end
