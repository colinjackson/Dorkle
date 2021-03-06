class GamesController < ApplicationController
  before_filter :require_signed_in, only: [:new, :create]
  before_filter :require_current_user_owner, only: [:edit, :update, :destroy]

  def index
    @games = Game.includes(:author).with_answers.last(10)
    render :index
  end

  def new
    @game = Game.new
    render :new
  end

  def create
    @game = current_user.created_games.new(game_params)
    if @game.save
      flash[:successes] = ["Your game has been uploaded!"]
      redirect_to game_url(@game)
    else
      flash.now[:errors] = ["Gadzooks!"] + @game.errors.full_messages
      @game = Game.new(game_params)
      render :new
    end
  end

  def show
    @game = Game.includes(:author).find(params[:id])
    render :show
  end

  def edit
    @game = current_user.created_games.find(params[:id])
    render :edit
  end

  def update
    @game = current_user.created_games.find(params[:id])
    if @game.update(game_params)
      flash[:successes] = ["Huzzah! Your changes have been saved!"]
      redirect_to game_url(@game)
    else
      flash.now[:errors] = ["Confound it!"] + @game.errors.full_messages
      render :edit
    end
  end

  def destroy
    @game = current_user.created_games.find(params[:id])
    @game.destroy
    redirect_to games_url
  end

  private
  def game_params
    params.require(:game)
      .permit(:title, :subtitle, :source, :time_limit, :image)
  end

  def require_current_user_owner
    if !signed_in? || Game.find(params[:id]).author_id != current_user.id
      redirect_to games_url
    end
  end

end
