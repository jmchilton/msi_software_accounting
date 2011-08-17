class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    users = User
    if perform_search?
      users = @users.where("username like ?", "%#{params[:username]}%")
    end
    @fields = [{ :field => "id", :label => "ID", :width => 35, :resizable => false },
               { :field => "username", :label => "Username" }]
    @rows = users
    @title = "Users"
    respond_with_table
  end

  # GET /users/1
  # GET /users/1.xml
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

end
