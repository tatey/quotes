class Admin::QuotesController < ApplicationController
  before_filter :require_user
  
  helper :quotes
  
  def index
    @quotes = Quote.unapproved
  end
  
  def edit
    @quote = Quote.find(params[:id])
  end
  
  def update
    @quote = Quote.find(params[:id])
    if @quote.update_attributes(params[:quote])
      flash[:info] = "Quote #{@quote.number} has been updated."
      redirect_to admin_quotes_path
    else
      render :action => 'update'
    end
  end
  
  def approve
    @quote = Quote.find(params[:id])
    @quote.approve
    flash[:info] = "Quote #{@quote.number} has been approved."
    redirect_to admin_quotes_path
  end
    
  def destroy
    @quote = Quote.find(params[:id]).destroy
    flash[:info] = "Quote #{@quote.number} has been destroyed."
    redirect_to :action => 'index'
  end
end
