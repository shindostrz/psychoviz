class QuizController < ApplicationController
  def index
    @questions = Quiz.all
  end

  def show

  end
end
