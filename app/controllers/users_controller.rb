class UsersController < ApplicationController
    def new()
        @user = User.new()
    end

    def create()
        @user = User.new(user_params)
        return redirect_to(new_user_path) unless @user.save
        session[:user_id] = @user.id
        redirect_to welcome_path(@user)
    end

    def welcome()
        return head(:forbidden) unless session.include? :user_id
        @user = User.find(session[:user_id])
    end

    private

    def user_params()
        params.require(:user).permit(:name, :password, :password_confirmation)
    end
end
