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
    @quote.votes.build(:vote_type => params[:vote_type]).save
    flash[:info] = 'Vote has been cast'
    redirect_to quotes_path
  end
  
  private
  
    def find_quote
      @quote = Quote.find(params[:quote_id])
    end
end
