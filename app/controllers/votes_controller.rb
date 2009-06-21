class VotesController < ApplicationController
  before_filter :find_quote
  
  def index
    @votes = @quote.votes
    respond_to do |format|
      format.html
      format.xml { render :xml => @votes.to_xml }
    end
  end
  
  def create
    @vote = @quote.votes.build(:vote_type => params[:vote_type])
    @vote.save
    flash[:info] = "#{Vote::VOTE_TYPES.index(@vote.vote_type).to_s.humanize} vote has been cast."
    redirect_to quotes_path
  end
  
  private
  
    def find_quote
      @quote = Quote.find(params[:quote_id])
    end
end
