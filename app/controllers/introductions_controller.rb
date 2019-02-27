class IntroductionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_introduction, only: [:show, :edit, :update, :destroy, :delete, :set_weight, :set_reveal]
  before_action :set_introductions, only: [:index, :set_weight, :set_reveal]
  before_action :set_left_bar
  access introduction: :all, message: "当前用户无权访问"

  # GET /introductions
  def index
  end

  def set_reveal
    @introduction.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def set_weight
    @introduction.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end

  # GET /introductions/1
  def show
  end

  # GET /introductions/new
  def new
    @introduction = current_user.introductions.new
  end

  # GET /introductions/1/edit
  def edit
  end

  # POST /introductions
  def create
    @introduction = current_user.introductions.new(introduction_params)

    if @introduction.save
      flash[:success] = "创建成功"
      redirect_to introductions_path
    else
      render :new
    end
  end

  # PATCH/PUT /introductions/1
  def update
    if @introduction.update(introduction_params)
      flash[:success] = "更新成功"
      redirect_to introductions_path
    else
      render :edit
    end
  end


  def delete
  end

  # DELETE /introductions/1
  def destroy
    @introduction.destroy
    flash[:success] = "删除成功"
    redirect_to introductions_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_introduction
      @introduction = current_user.introductions.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def introduction_params
      params.require(:introduction).permit(:title, :content)
    end

    def set_introductions
      @introductions = current_user.introductions.page(params[:page])
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
