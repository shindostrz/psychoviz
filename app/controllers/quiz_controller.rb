class QuizController < ApplicationController

  def index
    @questions = Quiz.all
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => { quiz: @questions }}
    end
  end

  def show


  end

end
