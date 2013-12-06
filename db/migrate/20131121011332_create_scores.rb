class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :e
      t.integer :i
      t.integer :s
      t.integer :n
      t.integer :t
      t.integer :f
      t.integer :j
      t.integer :p
      t.string :personality_type

      t.timestamps
    end
  end
end
