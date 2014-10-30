class StaticPagesController < ApplicationController

  def root
    @games = Game.last(3).reverse
    render :root
  end

  def backbone
    render :backbone
  end

end
