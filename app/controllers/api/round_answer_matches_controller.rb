module Api
  class RoundAnswerMatchesController < ApplicationController

    def index
      @round = Round.includes(:answer_matches, :answer).find(params[:round_id])
      render :index
    end

    def create
      @answer_match = RoundAnswerMatch.new(answer_match_params)

      if @answer_match.save
        render :show
      else
        render json: { error: @answer_match.errors.full_messages }
      end
    end

    private
    def answer_match_params
      params.require(:round_answer_match).permit(:round_id, :answer_id)
    end

  end
end
