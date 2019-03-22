class User < ApplicationRecord
  ############################################################################################
  ## PeterGate Roles                                                                        ##
  ## The :user role is added by default and shouldn't be included in this list.             ##
  ## The :root_admin can access any page regardless of access settings. Use with caution!   ##
  ## The multiple option can be set to true if you need users to have multiple roles.       ##
  petergate(roles: [:root_admin, :employee, :carousel, :map, :photograph, :article, 
  :introduction, :service, :feedback, :recruit, :contact, :plat,
  :category, :device], multiple: true)                                      ##
  ############################################################################################ 
 

  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :registerable, :lockable, :trackable,
         :recoverable, :rememberable, :validatable, :confirmable, :timeoutable

  validates :subdomain, exclusion: { in: %w(www), message: "%{value}是保留字段" }, presence: true, uniqueness: true

  has_many :options, dependent: :destroy
  has_many :officials, dependent: :destroy
  has_many :maps, dependent: :destroy
  has_many :employees, dependent: :destroy
  has_many :carousels, dependent: :destroy
  has_many :photographs, dependent: :destroy
  has_one :basic, dependent: :destroy
  has_one :logo, dependent: :destroy
  has_one :navbar, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :introductions, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :recruits, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :devices, dependent: :destroy

  after_create :set_role, :create_one_basic, :create_one_navbar, :sanitize_subdomain, :create_options

  def set_role
    self.roles = ["employee", "map", "introduction", "service", "article", "photograph", "feedback", "recruit", "carousel", "contact"]
    self.save
  end

  def create_one_basic
    self.create_basic(map_position: "", contact: "", background: "bg-white")
  end

  def create_one_navbar
    self.create_navbar(position: "", background: "bg-light", color: "text-dark")
  end

  def sanitize_subdomain
    self.subdomain = self.subdomain.parameterize
    self.save
  end

  def create_options
    self.options.create(name: "service", show: "服务内容")
    self.options.create(name: "article", show: "公司新闻")
    self.options.create(name: "feedback", show: "用户反馈")
    self.options.create(name: "recruit", show: "招聘信息")
    self.options.create(name: "carousel", show: "轮播图管理")
    self.options.create(name: "contact", show: "联系方式")
    self.options.create(name: "map", show: "公司地址")
    self.options.create(name: "introduction", show: "公司介绍")
    self.options.create(name: "photograph", show: "照片管理")
    self.options.create(name: "employee", show: "团队介绍")
  end
end
