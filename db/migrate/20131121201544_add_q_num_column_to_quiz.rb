class AddQNumColumnToQuiz < ActiveRecord::Migration
  def change
    change_table :quizzes do |t|
      t.integer :q_num
    end
  end
end
