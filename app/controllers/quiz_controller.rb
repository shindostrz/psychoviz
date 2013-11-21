class QuizController < ApplicationController
  def index
  end

  def show
    @questions = Quiz.all
    render :json => { quiz: @questions }
  end
end
