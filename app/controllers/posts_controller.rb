class PostsController < ApplicationController
  def new
    @post = Post.new(sub_id: params[:sub_id])
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author_id = current_user.id

    if @post.save
      redirect_to sub_url(@post.sub_id)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end
end
