class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  before_filter :gon_variables


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def gon_variables
    if current_user && current_user.score
      gon.e = current_user.score.e
      gon.i = current_user.score.i
      gon.s = current_user.score.s
      gon.n = current_user.score.n
      gon.j = current_user.score.j
      gon.f = current_user.score.f
      gon.t = current_user.score.t
      gon.p = current_user.score.p
      gon.personalityType = current_user.score.personality_type
      gon.user_score = current_user.score
    else
      gon.e, gon.i, gon.s, gon.n, gon.t, gon.f, gon.j, gon.p = 0, 0, 0, 0, 0, 0, 0, 0
    end
  end

end
