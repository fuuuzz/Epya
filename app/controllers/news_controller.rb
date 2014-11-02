class NewsController < ApplicationController
  before_action :set_new, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:edit, :update, :destroy, :new, :create]
  
  def index
   
  end
  
  def new
  end
  
  # POST-AJAX /projects/:id --> Project#new_tab
  def create
    @new = New.new(new_params)
    @new.user = current_user
    @new.project_id = params[:project_id]
    respond_to do |format|
      if @new.save
        format.js
      end
    end
  end

  def destroy
  end
  
  private
    def set_new
      @new = New.find(params[:id])
    end

    def new_params
      params.require(:new).permit(:content, :title, :project_id)
    end
end
