class ContactsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_contact, only: [:edit, :update, :destroy, :delete, :set_weight, :set_reveal]
  before_action :set_contacts, only: [:index, :set_weight, :set_reveal]
  before_action :set_left_bar
  access contact: :all, message: "当前用户无权访问"

  # GET /contacts
  def index
  end

  def set_reveal
    @contact.toggle!(:reveal)
    respond_to do |format|
      format.js do
      end
    end
  end

  def set_weight
    @contact.update(weight: Time.now)
    respond_to do |format|
      format.js do
      end
    end
  end

  # GET /contacts/new
  def new
    @contact = current_user.contacts.new
  end

  # GET /contacts/1/edit
  def edit
  end

  # POST /contacts
  def create
    @contact = current_user.contacts.new(contact_params)
    if @contact.save
      flash[:success] = "创建成功"
      redirect_to contacts_path
    else
      render :new
    end
  end

  # PATCH/PUT /contacts/1
  def update
    if @contact.update(contact_params)
      flash[:success] = "更新成功"
      redirect_to contacts_path
    else
      render :edit
    end
  end


  def delete
  end

  # DELETE /contacts/1
  def destroy
    @contact.destroy
    flash[:success] = "删除成功"
    redirect_to contacts_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contact
      @contact = current_user.contacts.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def contact_params
      params.require(:contact).permit(:telephone, :address, :wechat, :is_telephone, :is_address, :is_wechat)
    end

    def set_contacts
      @contacts = current_user.contacts.page(params[:page])
    end

    def set_left_bar
      @available_roles = current_user.roles.reject{ |role| (role == :user) || (role == :root_admin) }.map(&:to_s)
      @options = current_user.options.where(name: @available_roles).where(reveal: true).order(:position)
    end
end
