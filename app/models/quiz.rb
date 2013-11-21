class Quiz < ActiveRecord::Base
  attr_accessible :answer_a, :answer_b, :question, :q_num
end
