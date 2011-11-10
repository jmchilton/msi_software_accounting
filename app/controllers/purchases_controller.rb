class PurchasesController < TableController
  FIELDS = [id_field,
            {:field => lambda { |purchase| purchase.resource.name }, :label => "Resource"},
            {:field => "fy10", :label => "FY 2010"},
            {:field => "fy11", :label => "FY 2011"},
            {:field => "fy12", :label => "FY 2012"},
            {:field => "fy13", :label => "FY 2013"},
            {:field => "os", :label=> "Operating System" },
            link_field(:link_proc => "purchase_path")]


  def index
    @rows = Purchase
    respond_with_table(true)
  end

  def show
    find_and_show Purchase
  end

  def new
    @purchase = Purchase.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @purchase }
    end
  end

  def edit
    @purchase = Purchase.find(params[:id])
  end

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

  def destroy
    @purchase = Purchase.find(params[:id])
    @purchase.destroy

    respond_to do |format|
      format.html { redirect_to(purchases_url) }
      format.xml  { head :ok }
    end
  end

end
