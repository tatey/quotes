class QuotesController < ApplicationController
  def index
    @quotes = Quote.all
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
      flash[:info] = 'Quote created'
      redirect_to quotes_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @quote = Quote.find(params[:id])
  end
  
  def update
    @quote = Quote.find(params[:id])
    if @quote.update_attributes(params[:quote])
      flash[:info] = 'Quote updated'
      redirect_to @quote
    else
      render :action => 'update'
    end
  end
  
  def destroy
    Quote.find(params[:id]).destroy
    redirect_to :action => 'index'
  end
end
