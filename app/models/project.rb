class Project < ActiveRecord::Base
  belongs_to :tenant
  has_many :artefacts, dependent: :destroy
  
  has_many :user_projects
  has_many :users, through: :user_projects
  
  validates_uniqueness_of :title
  
  def self.by_user_plan_and_tenant(tenant_id, user)
        tenant = Tenant.find tenant_id
      
        if tenant.plan == 'premium'
            if user.admin?
                tenant.projects
            else
                user.projects.where(tenant_id: tenant.id)
            end
        else
            if user.admin?
                tenant.projects.order(:id).limit(1)
            else
                user.projects.where(tenant_id: tenant.id).order(:id).limit(1)
            end
        end
  end
end
