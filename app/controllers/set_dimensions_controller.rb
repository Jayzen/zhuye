class SetDimensionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_dimension 

  def logo
  end

  def set_logo
    @set_dimension.logo = params[:set_dimension][:logo]
    @set_dimension.save
    flash[:success] = "更新成功"
    redirect_to logo_set_dimensions_path
  end


  private
    def set_dimension
      @set_dimension = current_user.set_dimension
    end
end
