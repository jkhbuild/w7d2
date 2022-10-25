class UsersController < ApplicationController

    def show
        user = User.find_by(:id = params(:id))
        render :show
    end

    def new
        render :new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to user_url(@user)
        else
            render json: @user.error.full_messages, status 422
        end
    end

    def destroy
        @user = User.find_by(id: params[:id])
        @user.destroy
    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end

end