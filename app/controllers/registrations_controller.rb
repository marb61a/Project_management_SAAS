class RegistrationsController < Milia::RegistrationsController
    skip_before_action :authenticate_tenant!, only: [:new, :create, :cancel]
    
# ------------------------------------------------------------------------------
# ------------------------------------------------------------------------------
# TODO: options if non-standard path for new signups view
# ------------------------------------------------------------------------------
# create -- intercept the POST create action upon new sign-up
# new tenant account is vetted, then created, then proceed with devise create user
# CALLBACK: Tenant.create_new_tenant  -- prior to completing user account
# CALLBACK: Tenant.tenant_signup      -- after completing user account
# ------------------------------------------------------------------------------
    def create 
        # have a working copy of the params in case Tenant callbacks
        # make any changes
        tenant_params = sign_up_params_tenant
        user_params = sign_up_params_user.merge(admin: true)
        coupon_params = sign_up_params_coupon
        
        sign_out_session!
        
        # next two lines prep signup view parameters
        prep_signup_view( tenant_params, user_params, coupon_params )
        
        # validate recaptcha first unless not enabled
        if !::Milia.use_recaptcha || verify_recaptcha
            
        else
            
        end
    end
    
    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.for(:sign_up) +
            ::Milia.whitelist_user_params
        end
        
        def sign_up_params_tenant()
        end
        
        def sign_up_params_user()
        end
end