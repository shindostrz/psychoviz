class QuizController < ApplicationController
  def index
    @questions = Quiz.all
    render :json => { @questions }
  end
end
