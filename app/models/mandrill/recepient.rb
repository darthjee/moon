class Mandrill::Recepient < DelegateClass(RecursiveOpenStruct)
  def initialize(recepient)
    @recepient = RecursiveOpenStruct.new(recepient)
    super(@recepient)
  end

  def allowed?
    Mandrill.email_allowed? email
  end
end
