class FbAdresasController < ApplicationController
  # GET /fb_adresas
  # GET /fb_adresas.xml
  def index
    
    @search = params[:search]
    
    @search = 'a' if @search.nil?
    
    @fb_adresas = FbAdresa.find_by_id "(nazev like '#{@search}')"
    
    Rails.logger.debug "received #{@fb_adresas}"
    
    @fb_adresas = @fb_adresas.adresar

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @fb_adresas }
    end
  end

  # GET /fb_adresas/1
  # GET /fb_adresas/1.xml
  def show
    @fb_adresa = FbAdresa.find_by_id(params[:id])
    
    #@fb_adresa = @fb_adresa.adresar unless @fb_adresa.nil?
    @fb_adresas_hash = @fb_adresa.attributes.symbolize_keys
    @fb_adresas_keys = @fb_adresas_hash.keys.sort{|n,m| n.to_s <=> m.to_s }
    
    
    @fb_invoices = FbInvoice.find_by_id "(firma = #{@fb_adresa.id})"
    
    
    if @fb_invoices.respond_to?('faktura_vydana')
      
      
      if @fb_invoices.faktura_vydana.is_a?(Array)
        @fb_invoices = @fb_invoices.faktura_vydana 
        Rails.logger.debug "faktura nalezena, vracim jen ji "
      else
        cache = @fb_invoices
        @fb_invoices = Array.new
        @fb_invoices[0] = cache.faktura_vydana
        
        Rails.logger.debug "faktura single prevedena na aray #{@fb_invoices}"
      end
      
      
      
    else
      
      @fb_invoices = Hash.new
      Rails.logger.debug 'faktura nenalezena'
    end 
    
    Rails.logger.debug "invoices: #{@fb_invoices}"


    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @fb_adresa }
    end
  end

  # GET /fb_adresas/new
  # GET /fb_adresas/new.xml
  def new
    @fb_adresa = FbAdresa.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @fb_adresa }
    end
  end

  # GET /fb_adresas/1/edit
  def edit
    @fb_adresa = FbAdresa.find(params[:id])
  end

  # POST /fb_adresas
  # POST /fb_adresas.xml
  def create
    @fb_adresa = FbAdresa.new(params[:fb_adresa])

    respond_to do |format|
      if @fb_adresa.save
        format.html { redirect_to(@fb_adresa, :notice => 'Fb adresa was successfully created.') }
        format.xml  { render :xml => @fb_adresa, :status => :created, :location => @fb_adresa }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @fb_adresa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /fb_adresas/1
  # PUT /fb_adresas/1.xml
  def update
    @fb_adresa = FbAdresa.find(params[:id])

    respond_to do |format|
      if @fb_adresa.update_attributes(params[:fb_adresa])
        format.html { redirect_to(@fb_adresa, :notice => 'Fb adresa was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @fb_adresa.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /fb_adresas/1
  # DELETE /fb_adresas/1.xml
  def destroy
    @fb_adresa = FbAdresa.find(params[:id])
    @fb_adresa.destroy

    respond_to do |format|
      format.html { redirect_to(fb_adresas_url) }
      format.xml  { head :ok }
    end
  end
end
