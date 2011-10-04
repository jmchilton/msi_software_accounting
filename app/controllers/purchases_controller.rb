class PurchasesController < ApplicationController
  FIELDS = [id_field,
            {:field => lambda { |purchase| purchase.resource.name }, :label => "Resource"},
            {:field => "fy10", :label => "FY 2010"},
            {:field => "fy11", :label => "FY 2011"},
            {:field => "fy12", :label => "FY 2012"},
            {:field => "fy13", :label => "FY 2013"},
            {:field => "os", :label=> "Operating System" },
            link_field(:link_proc => "purchase_path")]
  TITLE = "Purchases"


  # GET /purchases
  # GET /purchases.xml
  def index
    @rows = Purchase
    @title = TITLE
    @fields = FIELDS

    respond_with_table(true)
  end

  # GET /purchases/1
  # GET /purchases/1.xml
  def show
    @purchase = Purchase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @purchase }
    end
  end

  # GET /purchases/new
  # GET /purchases/new.xml
  def new
    @purchase = Purchase.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @purchase }
    end
  end

  # GET /purchases/1/edit
  def edit
    @purchase = Purchase.find(params[:id])
  end

  # POST /purchases
  # POST /purchases.xml
  def create
    rid = Resource.find_by_name(params[:resource_name]).id
    params[:purchase][:rid] = rid
    @purchase = Purchase.new(params[:purchase])

    respond_to do |format|
      if @purchase.save
        format.html { redirect_to(@purchase, :notice => 'Purchase was successfully created.') }
        format.xml  { render :xml => @purchase, :status => :created, :location => @purchase }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /purchases/1
  # PUT /purchases/1.xml
  def update
    @purchase = Purchase.find(params[:id])
    params[:purchase][:rid] = Resource.find_by_name(params[:resource_name]).id
    respond_to do |format|
      if @purchase.update_attributes(params[:purchase])
        format.html { redirect_to(@purchase, :notice => 'Purchase was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @purchase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /purchases/1
  # DELETE /purchases/1.xml
  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to(purchases_url) }
      format.xml  { head :ok }
    end
  end
end
