class QuotesController < ApplicationController
  def index
    @quotes = Quote.approved
    respond_to do |format|
      format.html
      format.xml { render :xml => @quotes.to_xml }
    end
  end
  
  def show
    @quote = Quote.find(params[:id])
    respond_to do |format|
      format.html
      format.xml { render :xml => @quote.to_xml }
    end
  end
  
  def new
    @quote = Quote.new
  end
  
  def create
    @quote = Quote.new(params[:quote])
    if @quote.save
      flash[:info] = "Quote #{@quote.number} has been created."
      redirect_to quotes_path
    else
      render :action => 'new'
    end
  end
end
