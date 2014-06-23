class QuizController < ApplicationController

  def index
    @questions = Quiz.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => { quiz: @questions }}
    end
  end

  def get_friends
    @graph = Koala::Facebook::API.new(current_user.oauth_token)
    all_friends = @graph.get_connections("me", "friends")
    user_friends = []
    all_friends.each do |friend|
      if User.find_by_uid(friend["id"])
        user_friends << friend
      end
      user_friends
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => { friends: user_friends }}
    end

  end

end
