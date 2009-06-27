class QuotesController < ApplicationController
  before_filter :require_user, :only => [:edit, :update, :destroy]
  
  def index
    params[:order] ||= 'created_at_desc'
    params[:approval] = 'approved' unless current_user
    @quotes = Quote.find_by_options(params).paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.atom { render :layout => false }
      format.xml  { render :xml    => @quotes.to_xml }
      format.json { render :json   => @quotes.to_json }
    end
  end
  
  def show
    @quote = Quote.find(params[:id])
    respond_to do |format|
      format.html
      format.xml  { render :xml  => @quote.to_xml }
      format.json { render :json => @quote.to_json }
    end
  end
  
  def new
    @quote = Quote.new
  end
  
  def create
    @quote = Quote.new(params[:quote])
    if @quote.save
      flash[:info] = "Quote #{@quote.number} has been created and is waiting for approval by a moderator."
      redirect_to @quote
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
      flash[:info] = "Quote #{@quote.number} has been updated."
      redirect_to @quote
    else
      render :action => 'update'
    end
  end
    
  def destroy
    @quote = Quote.find(params[:id]).destroy
    flash[:info] = "Quote #{@quote.number} has been destroyed."
    redirect_to quotes_path
  end
end
