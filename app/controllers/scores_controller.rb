class ScoresController < ApplicationController

  def create
        result = []
        result.push(e, f, i, j, n, p, s, t)
    binding.pry
        type = result.sort!.slice(4..7)
        user = current_user
        user.scores.create(e: e, f: f, i: i, j: j, n: n, p: p, s: s, t: t, type: type)
  end

end