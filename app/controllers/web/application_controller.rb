class Web::ApplicationController < ApplicationController
  private

  def user_not_authorized
    flash.now[:alert] = 'Для выполнения данного действия необходимо авторизоваться.'
    redirect_back(fallback_location: root_path)
  end
end
