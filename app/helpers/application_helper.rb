module ApplicationHelper
    def tenant_name(tenant_id)
        Tenant.find(tenant_id).name
    end

end
