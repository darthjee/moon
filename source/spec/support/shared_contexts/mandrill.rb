# frozen_string_literal: true

shared_context 'email is not allowed' do
  before do
    Mandrill.config = Mandrill::Config.new(allowed_emails: /^$/)
  end
  after { Mandrill.config = nil }
end
