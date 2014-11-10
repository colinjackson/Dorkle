class StaticPagesController < ApplicationController

  def root
    @hot_games = Game.order(rounds_count: :desc).first(6)
    @best_players = User.order(completed_answer_matches_count: :desc).first(3)
    @best_authors =
      User.order(created_games_completed_rounds_count: :desc).first(3)
    render :root
  end

end
