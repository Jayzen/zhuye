class EmployeesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee, only: [:show, :edit, :update, :destroy, :delete, :set_reveal, :set_weight]
  before_action :set_employees, only: [:index, :set_reveal, :set_weight]
  before_action :set_left_bar
  access employee: :all, message: "当前用户无权访问"

  # GET /employees
  def index
  end

  def set_reveal
    @employee.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def set_weight
    @employee.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end 
  # GET /employees/1
  def show
  end

  # GET /employees/new
  def new
    @employee = current_user.employees.new
  end

  # GET /employees/1/edit
  def edit
  end

  # POST /employees
  def create
    @employee = current_user.employees.new(employee_params)

    if @employee.save
      flash[:success] = "创建成功"
      redirect_to employees_path
    else
      render :new
    end
  end

  # PATCH/PUT /employees/1
  def update
    if @employee.update(employee_params)
      flash[:success] = "更新成功"
      redirect_to employees_path
    else
      render :edit
    end
  end

  def delete
  end

  # DELETE /employees/1
  def destroy
    @employee.destroy
    flash[:success] = "删除成功"
    redirect_to employees_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_employee
      @employee = current_user.employees.find(params[:id])
    end

    def set_employees 
      @employees = current_user.employees.page(params[:page])
    end

    # Only allow a trusted parameter "white list" through.
    def employee_params
      params.require(:employee).permit(:name, :avatar, :deputy, :introduction)
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
