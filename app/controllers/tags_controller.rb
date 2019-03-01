class TagsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tag, only: [:show, :edit, :update, :destroy, :delete, :set_weight, :set_reveal]
  before_action :set_tags, only: [:index, :set_weight, :set_reveal]
  access root_admin: :all, message: "当前用户无权访问"

  # GET /tags
  def index
  end

  def set_reveal
    @tag.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def set_weight
    @tag.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end

  # GET /tags/1
  def show
  end

  # GET /tags/new
  def new
    @tag = current_user.tags.new
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  def create
    @tag = current_user.tags.new(tag_params)

    if @tag.save
      flash[:success] = "创建成功"
      redirect_to tags_path
    else
      render :new
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      flash[:success] = "更新成功"
      redirect_to tags_path
    else
      render :edit
    end
  end


  def delete
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
    flash[:success] = "删除成功"
    redirect_to tags_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = current_user.tags.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tag_params
      params.require(:tag).permit(:name)
    end

    def set_tags
      @tags = current_user.tags.page(params[:page])
    end
end
