class UsersController < ApplicationController
    def new
        @user =User.new
    end

    def create
        @user=User.create(user_paramas)

        if session[:user_id] = @user.id
        flash[:success] = "アカウトを作成しました。"
        redirect_to root_path
        else
        render :new
        end
    end

    def edit
    end

    def update
    end

    def destroy

    end

    private

    def user_paramas
        params.require(:user).permit(:name,:email,:password)
    end


end
