class ScoresController < ApplicationController
  def create
    results_hash = params[:data]
    personality_type = []

    if results_hash[:e] > results_hash[:i]
      personality_type.push("E")
    else
      personality_type.push("I")
    end

    if results_hash[:s] > results_hash[:n]
      personality_type.push("S")
    else
      personality_type.push("N")
    end

    if results_hash[:t] > results_hash[:f]
      personality_type.push("T")
    else
      personality_type.push("F")
    end

    if results_hash[:p] > results_hash[:j]
      personality_type.push("P")
    else
      personality_type.push("J")
    end

    user = current_user
    user.create_score(e: results_hash[:e], f: results_hash[:f], i: results_hash[:i], j: results_hash[:j], n: results_hash[:n], p: results_hash[:p], s: results_hash[:s], t: results_hash[:t], personality_type: personality_type.join(","))
    render :nothing => true
  end

end
