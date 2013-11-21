class QuizController < ApplicationController
  def index
    @questions = Quiz.all.each { |i| i.question }
  end
end
