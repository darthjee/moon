class Marriage::PasswordsController < ApplicationController
  include Marriage::Common

  protect_from_forgery except: :create

  def recovery
  end
end
