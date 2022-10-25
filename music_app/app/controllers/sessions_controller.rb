class SessionController << ApplicationController


    def new
        render :new
    end

    def create
        @user = User.find_by_credentials(params[:user][:username], params[:users][:password])

        if @user
            login(@user)
            redirect_to user_url(@user)
        else
            render :new
        end
    end


    def destroy
        logout!
        redirect_to new_session_url
    end


end