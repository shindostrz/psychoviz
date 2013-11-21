class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.boolean :e
      t.boolean :i
      t.boolean :s
      t.boolean :n
      t.boolean :t
      t.boolean :f
      t.boolean :j
      t.boolean :p
      t.string :type

      t.timestamps
    end
  end
end
