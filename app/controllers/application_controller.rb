class ApplicationController < ActionController::Base
  before_action :set_user

  private

  def set_user    
    session[:current_user_id] = session[:current_user_id].presence || SecureRandom.uuid
  end
end
