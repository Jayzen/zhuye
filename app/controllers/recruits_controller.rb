class RecruitsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_recruit, only: [:show, :edit, :update, :destroy, :delete, :set_weight, :set_reveal]
  before_action :set_recruits, only: [:index, :set_weight, :set_reveal]
  before_action :set_left_bar
  access recruit: :all, message: "当前用户无权访问"

  # GET /recruits
  def index
  end

  def set_reveal
    @recruit.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def set_weight
    @recruit.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end

  # GET /recruits/1
  def show
  end

  # GET /recruits/new
  def new
    @recruit = current_user.recruits.new
  end

  # GET /recruits/1/edit
  def edit
  end

  # POST /recruits
  def create
    @recruit = current_user.recruits.new(recruit_params)

    if @recruit.save
      flash[:success] = "创建成功"
      redirect_to recruits_path
    else
      render :new
    end
  end

  # PATCH/PUT /recruits/1
  def update
    if @recruit.update(recruit_params)
      flash[:success] = "更新成功"
      redirect_to recruits_path
    else
      render :edit
    end
  end


  def delete
  end

  # DELETE /recruits/1
  def destroy
    @recruit.destroy
    flash[:success] = "删除成功"
    redirect_to recruits_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recruit
      @recruit = current_user.recruits.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recruit_params
      params.require(:recruit).permit(:title, :content)
    end

    def set_recruits
      @recruits = current_user.recruits.page(params[:page])
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
