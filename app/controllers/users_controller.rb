class UsersController < ApplicationController

  def index
    @users = User.all.order({ :username => :asc })
    render({ :template => "users/index.html" })
  end

  def show
    the_username = params.fetch(:path_username)
    @user = User.where({ :username => the_username }).at(0)

    render({ :template => "users/show.html.erb" })
  end

  def create
    user = User.new

    user.username = params.fetch(:query_username)
    user.private = params.fetch(:query_private)
    user.likes_count = params.fetch(:query_likes_count, 0)
    user.comments_count = params.fetch(:query_comments_count, 0)
    user.password = params.fetch(:query_password)
    user.password_confirmation = params.fetch(:query_password_confirmation)
    
    save_status = user.save

    if save_status == true
      session[:user_id] = user.id
      
      redirect_to("/users/#{user.username}")
    else
      redirect_to("/sign_up", { :alert => "Something went wrong. Please try again." })
    end
  end

  def update
    the_id = params.fetch(:path_id)
    user = User.where({ :id => the_id }).at(0)


    user.username = params.fetch(:query_username)
    user.private = params.fetch(:query_private, false)
    
    user.save

    redirect_to("/users/#{user.username}")
  end

  def liked_photos
    username = params.fetch(:path_username)
    @user = User.where({ :username => username }).at(0)
  
    render({ :template => "users/liked_photos.html.erb" })
  end

  def feed
    username = params.fetch(:path_username)
    @user = User.where({ :username => username }).at(0)
  
    render({ :template => "users/feed.html.erb" })
  end

  def discover
    username = params.fetch(:path_username)
    @user = User.where({ :username => username }).at(0)

    render({ :template => "users/discover.html.erb" })
  end

end
