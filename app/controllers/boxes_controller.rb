class BoxesController < ApplicationController
  before_action :find_box, only: [:edit, :update, :destroy, :show]

  def index
    @boxes = Box.all
    @box = Box.new
  end

  def new
    @box = Box.new
  end

  def show
    @contents = @box.contents
  end

  def create
    @box = Box.new(box_params)
    if @box.save
      redirect_to boxes_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @box.update(box_params)
      redirect_to boxes_path
    else
      render :edit
    end
  end

  def destroy
    @box.destroy
    redirect_to boxes_path
  end

  private 

  def find_box
    @box = Box.find(params[:id])
  end

  def box_params
    params.require(:box).permit(:code)
  end
end
