#trida zpristupnujici fakturu (vydanou) ve flexibee

class FbInvoice < FbConnect
  

  #budeme pristupovat k evidenci "faktura-vydana"
  self.element_name = "faktura-vydana"
  
  self.format = :xml
  
  self.url_params = FbConnect.url_params #"?mode=ruby"

  def self.new_invoice args={}
    
    default_args = {
      :primUcet=>config.flexibee_fakt_primUcet,
      :protiUcet=>config.flexibee_fakt_protiUcet,
      :typUcOp=>config.flexibee_fakt_typUcOp,
      :bankovniUcet=>config.flexibee_fakt_bankovniUcet,
      :clenDph=>config.flexibee_fakt_clenDph,
      :formaUhrK=>config.flexibee_fakt_formaUhrK_hotove,
      :bezPolozek=>"true",
      :typDokl=>"code:FAKTURA",
      :formaUhrK=>'formaUhr.prevod'
      
    
    }#:stat=>"code:CZ", :poznam=>'Automaticky vytvoreno v estu', :postovniShodna=>true}
    
    #args = Hash.new
    #args[:firma]='code:PBENDA'
    #FbInvoice.new_invoice args
    
#args=    {:firma=>"code:PBENDA", :bezPolozek=>"false", :polozkyFaktury=>[{"faktura-vydana-polozka"=>{:cenaMj=>"5400", :nazev=>"Nazev radky polozky", :typSzbDphK=>"typSzbDph.dphOsv", :typPolozkyK=>"typPolozky.obecny", :mnozMj=>"1", :typCenyDphK=>"typCeny.bezDph", :szbDph=>"0"}}]}
    
    self.new_record default_args.merge( args)
  end
  
  
  def self.get_polozka_defaults
    r = Hash.new
    
    #r[:cenaMj]="5400"
    #r[:nazev]="Nazev radky polozky"
    r[:typSzbDphK]="typSzbDph.dphOsv"
    r[:typPolozkyK]="typPolozky.obecny"
    #r[:mnozMj]="1"
    r[:typCenyDphK]="typCeny.bezDph"
    r[:szbDph]="0"
    
    r
    
  end
  

  
  def self.find_by_id1 id, params={}
         
    tu = self.url_root_path + self.element_name
    
    tu = tu + "/" + id.to_s + ".json"
    
    tu = tu + self.url_params
    
    
    
    result = connection.get tu,   {'Accept'=>'application/json', 'mode'=>'ruby'}
    result = result['faktura-vydana']
    result.symbolize_keys!
    
    #ret=ActiveSupport::JSON.decode( result.body)['winstrom']
    
    #logger.debug "received response #{ret}"
  
     #ret
     
     #=> {:primUcet=>"code:311001", :typDokl=>"code:FAKTURA", :bezPolozek=>true, "zklMdUcet"=>"code:311001", :polozkyFaktury=>nil}
    
  end
  
  
     #url na kterem jsou vsechny faktury zadane firmy
  def self.url id
    
    r = self.site.to_s + "faktura-vydana/#{id.to_s}" unless id.nil?
    
    r = self.site.to_s + "faktura-vydana/" if id.nil?
    
    r
  end
  
  
end