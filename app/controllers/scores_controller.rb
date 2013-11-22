class ScoresController < ApplicationController
  def create
    user = current_user
    user.score.create(e: e, f: f, i: i, j: j, n: n, p: p, s: s, t: t, type: type)
  end
end
