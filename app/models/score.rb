class Score < ActiveRecord::Base
  attr_accessible :e, :f, :i, :j, :n, :p, :s, :t, :type

  belongs_to :user
end
