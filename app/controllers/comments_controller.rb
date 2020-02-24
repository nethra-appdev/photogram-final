class CommentsController < ApplicationController
  def create
    comment = Comment.new

    comment.author_id = @current_user.id
    comment.photo_id = params.fetch(:query_photo_id)
  comment.body = params.fetch(:query_body)
    
    comment.save

    @current_user.comments_count = @current_user.comments_count + 1
    @current_user.save

    photo = Photo.where({ :id => comment.photo_id }).at(0)
    photo.comments_count = photo.comments_count + 1
    photo.save
    
    redirect_to("/photos/#{comment.photo_id}")
  end

end
