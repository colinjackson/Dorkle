class StaticPagesController < ApplicationController

  def root
    @hot_games = Game.order(:rounds_count).last(5)
    render :root
  end

end
