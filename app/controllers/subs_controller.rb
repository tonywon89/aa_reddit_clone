class SubsController < ApplicationController
  before_action :is_moderator, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id

    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
    @sub = Sub.find_by(id: params[:id])

    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end

  end

  def destroy
  end

  private

  def sub_params
    params[:sub_forum].permit(:title, :description)
  end

  def is_moderator
    @sub = Sub.find_by(id: params[:id])
    unless current_user.id == @sub.moderator_id
      flash[:errors] = ["Only the moderator can edit a Sub ReadIt!"]
      redirect_to sub_url(@sub)
    end
  end
end
