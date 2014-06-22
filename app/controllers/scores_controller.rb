class ScoresController < ApplicationController
  def create
    results_hash = params[:data]
    user = current_user
    user.create_score(e: results_hash[:e], f: results_hash[:f], i: results_hash[:i], j: results_hash[:j], n: results_hash[:n], p: results_hash[:p], s: results_hash[:s], t: results_hash[:t], personality_type: results_hash[:personality_type].join(",").gsub(',', ''))
    render :nothing => true
  end

end
