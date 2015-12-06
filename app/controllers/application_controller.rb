class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def admin_key
    ENV['ADMIN_KEY']
  end

  def require_admin
    head :forbidden unless is_admin?
  end

  def is_admin?
    params[:admin_key] == admin_key
  end

  def not_found
    head :not_found
  end

  def cached_render(view)
    Rails.cache.fetch "render:#{params[:controller]}:#{view}" do
      render view
    end
  end
end
