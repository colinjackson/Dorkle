class StaticPagesController < ApplicationController

  def root
    redirect_to games_url
  end

end
