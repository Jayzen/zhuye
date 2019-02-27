class FeedbacksController < ApplicationController
  before_action :authenticate_user!, except: [:create]
  before_action :ensure_subdomain, :find_options, only: [:create]
  before_action :set_feedback, only: [:show, :destroy, :delete]
  before_action :set_feedbacks, only: [:index]
  before_action :set_left_bar, except: [:create]
  #添加下面语句会返回错误
  #access feedback: [:delete, :destroy], message: "当前用户无权访问"

  def create
    @feedback = Feedback.new(feedback_params)
    @feedback.user_id = @show_user.id
    if @feedback.save
      flash[:success] = "反馈成功"
      redirect_to echo_path
    else
      @contact = @show_user.contacts.first
      flash[:danger] = "联系方式或评论内容不能为空"
      redirect_to echo_path
    end
  end

  def index
  end

  def show
    unless @feedback.status?
      @feedback.toggle!(:status)
    end
  end

  def delete
  end

  def destroy
    @feedback.destroy
    flash[:success] = "删除成功"
    redirect_to feedbacks_path
  end
 
  private
    def feedback_params
      params.require(:feedback).permit(:name, :content)
    end

    def ensure_subdomain
      @show_user ||= User.find_by(subdomain: request.subdomain)
      @contact = @show_user.contacts.where(reveal: true).first
      redirect_to root_url(subdomain: nil) unless @show_user.present?
    end

    def find_options
      @available_roles = @show_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = @show_user.options.where(name: @available_roles).where(reveal: true).order(:position)
      @carousels = @show_user.carousels.where(reveal: true)
      if @show_user.options.find_by(name: "carousel")
        @carousel_option = @show_user.options.find_by(name: "carousel").reveal
      end 
    end

    def set_feedback
      @feedback = current_user.feedbacks.find(params[:id])
    end

    def set_feedbacks
      @feedbacks = current_user.feedbacks.page(params[:page])
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
