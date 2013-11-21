class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.string :question
      t.string :answer_a
      t.string :answer_b

      t.timestamps
    end
  end
end
