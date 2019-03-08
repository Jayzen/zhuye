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
  has_one :set_advertise, dependent: :destroy
  has_one :set_dimension, dependent: :destroy
  has_one :logo, dependent: :destroy
  has_many :contacts, dependent: :destroy
  has_many :introductions, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :services, dependent: :destroy
  has_many :recruits, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :pictures, dependent: :destroy
  has_many :tags, dependent: :destroy
  has_many :categories, dependent: :destroy
  has_many :devices, dependent: :destroy

  after_create :set_role, :create_one_basic, :sanitize_subdomain
  
  def set_role
    self.roles = 'user'
    self.save
  end

  def create_one_basic
    self.create_basic
  end

  def sanitize_subdomain
    self.subdomain = self.subdomain.parameterize
    self.save
  end
end
