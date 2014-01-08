class ScoresController < ApplicationController
  def create
    results_hash = params[:data]
    results = results_hash.sort_by { |k,v| v }
    score = results.slice(4..7)
    personality_type = score.each { |i| i[0] }
    user = current_user
    user.create_score(e: results_hash[:e], f: results_hash[:f], i: results_hash[:i], j: results_hash[:j], n: results_hash[:n], p: results_hash[:p], s: results_hash[:s], t: results_hash[:t], personality_type: personality_type.join(","))
    render :nothing => true
  end

end
