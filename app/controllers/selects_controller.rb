class SelectsController < ApplicationController
  before_action :authenticate_user!

  def select
    if current_user.option
      redirect_to select_path
    end
  end

  def advertise
    current_user.option = "advertise"
    current_user.roles = ["introduction", "employee", "carousel", "photograph", "article", "contact"]
    current_user.save
    create_options
    create_set_advertise
    redirect_to options_path
  end

  def official
    current_user.option = "official"
    current_user.roles = ["introduction", "service", "article", "feedback", "recruit", "carousel", "contact"]
    current_user.save
    create_options
    redirect_to options_path
  end

  def dimension
    current_user.option = "dimension"
    current_user.roles = ["category", "device"]
    current_user.save
    create_options
    create_set_dimension
    redirect_to options_path
  end 

  private
    def create_options
      current_user.options.destroy_all
      case current_user.option
      when "advertise"
        current_user.options.create(name: "employee", show: "员工管理")
        current_user.options.create(name: "photograph", show: "照片管理")
        current_user.options.create(name: "article", show: "文章管理") 
        current_user.options.create(name: "carousel", show: "轮播图管理")
        current_user.options.create(name: "contact", show: "联系方式")
        current_user.options.create(name: "introduction", show: "公司介绍")
      when "official"
        current_user.options.create(name: "introduction", show: "公司介绍")
        current_user.options.create(name: "service", show: "服务内容")
        current_user.options.create(name: "article", show: "公司新闻")
        current_user.options.create(name: "feedback", show: "用户反馈")
        current_user.options.create(name: "recruit", show: "招聘信息")
        current_user.options.create(name: "carousel", show: "轮播图管理")
        current_user.options.create(name: "contact", show: "联系方式")
      when 'dimension'
        current_user.options.create(name: "category", show: "分类管理")
        current_user.options.create(name: "device", show: "设备管理")
      end
    end

    def create_set_advertise
      current_user.create_set_advertise(contact: "", map_height: 200)
    end

    def create_set_dimension
      current_user.create_set_dimension(logo: "")
    end
end
