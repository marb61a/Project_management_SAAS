class ConfirmationsController < Milia::ConfirmationsController
    before_action :set_confirmable, only: [:update, :show]
    
    def update
        
    end
    
    def show
        if @confirmable.new_record?  ||
            !::Milia.use_invite_member || 
            @confirmable.skip_confirm_change_password
            
            log_action( "devise pass-thru" )
            self.resource = resource_class.confirm_by_token(params[:confirmation_token])
            yield resource if block_given?
            
            if resource.errors.empty?
            set_flash_message(:notice, :confirmed) if is_flashing_format?
            end
            
            if @confirmable.skip_confirm_change_password
            # sign in automatically
            sign_in_tenanted_and_redirect(resource)
            end

        else
              log_action( "password set form" )
              flash[:notice] = "Please choose a password and confirm it"
              prep_do_show()  # prep for the form
        end
            # else fall thru to show template which is form to set a password
            # upon SUBMIT, processing will continue from update
    end
    
    def after_confirmation_path_for(resource_name, resource)
        if user_signed_in?
          root_path
        else
          new_user_session_path
        end
    end
    
    private
        def set_confirmable
            @confirmable = User.find_or_initialize_with_error_by(:confirmation_token, params[:confirmation_token])    
        end
end