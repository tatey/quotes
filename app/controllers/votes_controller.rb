class VotesController < ApplicationController
  def create
    @quote = Quote.find(params[:quote_id])
    @vote = @quote.votes.build(:vote_type => params[:vote_type])
    @vote.save
    flash[:info] = "#{Vote::VOTE_TYPES.index(@vote.vote_type).to_s.humanize} vote has been cast."
    redirect_to quotes_path
  end
end
