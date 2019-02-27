class AdminsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:delete, :destroy, :privileges, :update_privilege]
  access root_admin: :all, message: "当前用户无权访问"

  def index
    @users = User.all.page(params[:page])
  end

  def delete
  end

  def search
    term = params[:email].strip
    @users = User.where(["email =  ?", "#{term}"]).page(params[:page])
    render 'index'
  end

  def destroy
    @user.destroy
    flash[:success] = "用户删除成功"
    redirect_to admins_path
  end

  def privileges
    @options = @user.roles.reject{ |role| (role == :user) || (role == :root_admin) }
  end


  def update_privilege
    @user.roles = params[:privilege].keys.reject{|key| key=="not_nil"}.map(&:to_sym)
    @user.save
    flash[:success] = "权限更新成功"
    redirect_to privileges_admin_path(@user)
  end

  private
    def set_user
      @user = User.find(params[:id])
    end
end
