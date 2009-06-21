class Admin::UsersController < ApplicationController
  before_filter :require_user
  
  def index
    @users = User.all   
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:info] = "#{@user.first_name} has been created."
      redirect_to admin_users_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:info] = "#{@user.first_name} has been updated."
      redirect_to admin_users_path
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id]).destroy
    flash[:info] = "#{@user.first_name} has been destroyed."
    redirect_to admin_users_path
  end
end
