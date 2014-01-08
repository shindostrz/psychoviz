class Score < ActiveRecord::Base
  attr_accessible :e, :f, :i, :j, :n, :p, :s, :t, :personality_type, :user_id

  belongs_to :user

  protected

  def self.calc_type
    result = []
    result.push(e, f, i, j, n, p, s, t)
    type = result.sort!.slice(4..7)
  end

end
