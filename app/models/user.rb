class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :company
  default_scope { order(:name) }

  before_validation { self.role ||= :company_user }
  validates :company, :role, presence: :true

  scope :find_all_by_approved, ->(status) { where approved: status }

  def self.max_privilege maximum_role
    users = []

    Rails.application.config.user_roles.each do |role, privilege|
      unless privilege[:privilege] > Rails.application.config.user_roles[maximum_role.to_sym][:privilege]
        users += User.where(role: role).ids
      end
    end

    scope_users = User.where(id: [users])
  end

  def to_s
    name
  end

  def active_for_authentication? 
    super && (approved? || is?(:superadmin))
  end 

  def inactive_message 
    if !approved? 
      :not_approved 
    else 
      super # Use whatever other message 
    end 
  end

  def is_at_least? minimum_role
    Rails.application.config.user_roles[role.to_sym][:privilege] >= Rails.application.config.user_roles[minimum_role.to_sym][:privilege]
  end

  def has_more_privileges_than? minor_role
    Rails.application.config.user_roles[role.to_sym][:privilege] > Rails.application.config.user_roles[minor_role.to_sym][:privilege]
  end

  def is_at_most? maximum_role
    Rails.application.config.user_roles[role.to_sym][:privilege] <= Rails.application.config.user_roles[maximum_role.to_sym][:privilege]
  end

  def is? specific_role
    Rails.application.config.user_roles[role.to_sym][:privilege] == Rails.application.config.user_roles[specific_role.to_sym][:privilege]
  end

  def is_not? specific_role
    Rails.application.config.user_roles[role.to_sym][:privilege] != Rails.application.config.user_roles[specific_role.to_sym][:privilege]
  end

end
