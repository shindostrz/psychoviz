class Score < ActiveRecord::Base
  attr_accessible :e, :f, :i, :j, :n, :p, :s, :t, :personality_type, :user_id

  belongs_to :user
end
