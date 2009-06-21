class Admin::QuotesController < ApplicationController
  before_filter :require_user
  
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
  
  def destroy
    @quote = Quote.find(params[:id]).destroy
    flash[:info] = "Quote #{@quote.number} has been destroyed."
    redirect_to :action => 'index'
  end
end
