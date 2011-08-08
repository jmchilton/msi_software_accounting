class UsersController < ApplicationController
  # GET /users
  # GET /users.xml
  def index
    @users = with_pagination_and_ordering(User)
    if perform_search?
      @users = @users.where("username like ?", "%#{params[:username]}%")
    end
    @users = @users.all
    @fields = [{ :field => "id", :label => "ID", :width => 35, :resizable => false },
               { :field => "username", :label => "Username" }]
    @title = "Users"
    respond_to do |format|
      format.html { render :html => @users }# index.html.erb
      format.xml  { render :xml => @users }
      format.json { render :json => @users.to_jqgrid_json([:id, :username], params[:page], params[:rows], @users.count) }
    end
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
