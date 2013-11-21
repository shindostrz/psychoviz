class QuizController < ApplicationController
  def index
    @questions = Quiz.all
    render :json => { quiz: @questions }
  end
end
