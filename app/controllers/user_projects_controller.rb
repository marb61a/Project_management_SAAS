class UserProjectsController < ApplicationController
    before_action :set_user_project, only: [:show, :edit, :update, :destroy]
    
    # GET /user_projects
    # GET /user_projects.json
    def index
        @user_projects = UserProject.all
    end
    
    # GET /user_projects/1
    # GET /user_projects/1.json
    def show
    end
    
    # GET /user_projects/new
    def new
        @user_project = UserProject.new
    end
    
    # GET /user_projects/1/edit
    def edit
    end
    
    # POST /user_projects
    # POST /user_projects.json
    def create
        
    end
    
    private
        # Use callbacks to share common setup or constraints between actions.
        def set_user_project
            @user_project = UserProject.find(params[:id])    
        end
        
        # Never trust parameters from the scary internet, only allow the white list through.
        def user_project_params
            params.require(:user_project).permit(:project_id, :user_id)
        end
end