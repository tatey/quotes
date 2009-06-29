class QuotesController < ApplicationController
  before_filter :require_user, :only => [:edit, :update, :destroy]
  
  def index
    params[:order] ||= 'created_at_desc'
    if current_user
      @unapproved_count = Quote.unapproved.count unless Quote.unapproved.count.zero?
    else
      params[:approval] = 'approved'
    end
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
    if @quote.approved?
      respond_to do |format|
        format.html
        format.xml  { render :xml  => @quote.to_xml }
        format.json { render :json => @quote.to_json }
      end
    else
      render "#{RAILS_ROOT}/public/404.html", :status => 404
    end
  end
  
  def new
    @quote = Quote.new
  end
  
  def create
    @quote = Quote.new(params[:quote])
    if @quote.save
      if current_user
        @quote.update_attribute(:approved, true)
        flash[:info] = "Quote #{@quote.number} has been submitted."
      else
        flash[:info] = "Quote #{@quote.number} has been submitted and is waiting for approval by a moderator."
      end
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
      flash[:info] = "Quote #{@quote.number} has been updated."
      redirect_to @quote
    else
      render :action => 'edit'
    end
  end
    
  def destroy
    @quote = Quote.find(params[:id]).destroy
    flash[:info] = "Quote #{@quote.number} has been destroyed."
    redirect_to quotes_path
  end
end
