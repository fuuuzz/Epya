class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :index]
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :is_good_user, only: [:edit, :update]
  
  # GET /pages
  # GET /pages.json
  def index
    @user = User.find(params[:id])
  end

  # GET /pages/1
  # GET /pages/1.json
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :name)
    end
    
    def is_good_user
      if params[:id] != current_user.id
        respond_to do |format|
          format.html { redirect_to @user, notice: "Vous n'avez pas le droit de modifier un autre profil que le vôtre, try again !" }
        end
      end
    end
    
end
