class ResourcesController < ApplicationController

  def report
    @rows = Resource.find(:all,
                          :select => "resources.rid, resources.name, count(distinct users.id) as num_users, count(distinct groups.gid) as num_groups",
                          :group => "resources.name",
                          :conditions => "event.operation = 'OUT'",
                          :joins => [{:events => { :process_user => :group}}])
    @rows.each do |row| 
      purchases = Resource.find(row.rid, :include => :purchases).purchases
      row[:fy10] = purchases.map { |purchase| purchase.fy10 || 0 }.sum()
      row[:fy11] = purchases.map { |purchase| purchase.fy11 || 0 }.sum()
      row[:fy12] = purchases.map { |purchase| purchase.fy12 || 0 }.sum()
      row[:fy13] = purchases.map { |purchase| purchase.fy13 || 0 }.sum()
    end
  end

  # GET /resources
  # GET /resources.xml
  def index
    @resources = Resource.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @resources }
    end
  end

  # GET /resources/1
  # GET /resources/1.xml
  def show
    @resource = Resource.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/new
  # GET /resources/new.xml
  def new
    @resource = Resource.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @resource }
    end
  end

  # GET /resources/1/edit
  def edit
    @resource = Resource.find(params[:id])
  end

  # POST /resources
  # POST /resources.xml
  def create
    @resource = Resource.new(params[:resource])

    respond_to do |format|
      if @resource.save
        format.html { redirect_to(@resource, :notice => 'Resource was successfully created.') }
        format.xml  { render :xml => @resource, :status => :created, :location => @resource }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /resources/1
  # PUT /resources/1.xml
  def update
    @resource = Resource.find(params[:id])

    respond_to do |format|
      if @resource.update_attributes(params[:resource])
        format.html { redirect_to(@resource, :notice => 'Resource was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @resource.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /resources/1
  # DELETE /resources/1.xml
  def destroy
    @resource = Resource.find(params[:id])
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to(resources_url) }
      format.xml  { head :ok }
    end
  end
end
