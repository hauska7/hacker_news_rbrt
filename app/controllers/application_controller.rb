class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def queries
    QueriesAR.build
  end

  def persistance
    Persistance.build
  end
end
