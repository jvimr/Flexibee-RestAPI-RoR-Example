class FbInvoicesController < ApplicationController
  # GET /fb_invoices
  # GET /fb_invoices.xml
  def index
    @fb_invoices = FbInvoice.find_by_id '(firma = 399)'

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fb_invoices }
    end
  end

  # GET /fb_invoices/1
  # GET /fb_invoices/1.xml
  def show
    @fb_invoice = FbInvoice.find_by_id(params[:id])
    
    
    @fb_invoice_hash = @fb_invoice.attributes.symbolize_keys
    @fb_invoice_keys = @fb_invoice_hash.keys.sort{|n,m| n.to_s <=> m.to_s }

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fb_invoice }
    end
  end

  # GET /fb_invoices/new
  # GET /fb_invoices/new.xml
  def new
    @fb_invoice = FbInvoice.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fb_invoice }
    end
  end

  # GET /fb_invoices/1/edit
  def edit
    @fb_invoice = FbInvoice.find(params[:id])
  end

  # POST /fb_invoices
  # POST /fb_invoices.xml
  def create
    @fb_invoice = FbInvoice.new(params[:fb_invoice])

    respond_to do |format|
      if @fb_invoice.save
        format.html { redirect_to(@fb_invoice, :notice => 'Fb invoice was successfully created.') }
        format.xml  { render :xml => @fb_invoice, :status => :created, :location => @fb_invoice }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fb_invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fb_invoices/1
  # PUT /fb_invoices/1.xml
  def update
    @fb_invoice = FbInvoice.find(params[:id])

    respond_to do |format|
      if @fb_invoice.update_attributes(params[:fb_invoice])
        format.html { redirect_to(@fb_invoice, :notice => 'Fb invoice was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fb_invoice.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fb_invoices/1
  # DELETE /fb_invoices/1.xml
  def destroy
    @fb_invoice = FbInvoice.find(params[:id])
    @fb_invoice.destroy

    respond_to do |format|
      format.html { redirect_to(fb_invoices_url) }
      format.xml  { head :ok }
    end
  end
end
