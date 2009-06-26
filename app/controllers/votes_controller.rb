class VotesController < ApplicationController
  def create
    @quote = Quote.find(params[:quote_id])
    @vote = @quote.votes.build(:vote_type => params[:vote_type])
    if @vote.save
      flash[:info] = "#{Vote::VOTE_TYPES.index(@vote.vote_type).to_s.humanize} vote has been cast."
    else
      flash[:notice] = 'Vote must be up or down'
    end
    redirect_to :back
  end
end
