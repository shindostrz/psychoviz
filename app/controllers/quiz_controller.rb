class QuizController < ApplicationController

  def index
    @questions = Quiz.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => { quiz: @questions }}
    end
  end

  def get_friends
    all_friends = current_user.facebook.get_connections("me", "friends")
    user_friends = []
    all_friends.each do |friend|
      current_friend = User.find_by_uid(friend["id"])
      if current_friend
        current_friend[:score] = current_friend.score
        user_friends << current_friend
      end
      user_friends
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => user_friends, :only => [:id, :name, :image, :score]}
    end

  end

end
