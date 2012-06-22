
#predek objektu pracujicich s pripojenim do FlexiBee pres RestApi
class FbConnect < ActiveResource::Base
  
  #zjednoduseni pristupu k hodnotam v configu
  def self.config 
    FlexibeeConnect::Application.config
  end
  
  #vrati prvni cast url pro pripojeni - az po port (t.j. napr http://demo.flexibee.eu:80)
  def self.url_proto_host_port
    config.flexibee_proto + "://" + config.flexibee_host + ":" + config.flexibee_port
  end
  
  #vrati prvni cast cesty v url, bez host:port
  #t.j. v nasem pripade vrati /c/demo/
  def self.url_root_path
    "/c/" + config.flexibee_firma + "/" # + element_name
  end
  
  #vrati cele url na ktere se pripojujeme
  #volano z metod predka pri navazovani pripojeni 
  def self.site 
   # super.site
    URI.parse url_proto_host_port + url_root_path
  end

  #nastaveni jmena a hesla pro pripojeni
  self.user = config.flexibee_user
  self.password = config.flexibee_password
  
  #jmeno elementu pro pripojeni - je prepsano v potomkovi, ale pro testovani pouzijeme tento
  self.element_name = "adresar"
  
  #budeme komunikovat ve formatu json, mozna bychom mohli pouzit xml
  #self.format = :json
  

  
  def   self.default_url_params_map 
     {:mode=>'ruby'}
  end;
  
  
  
  def self.url_params
    @url_params
  end
  
  def self.url_params= (arg)
    @url_params = arg
  end
  
  #url parametry - pouzite pri sestavovani celeho url  rucne
  self.url_params =   "?mode=ruby"
  

  
  #url kam se pripojuje pro aktualni agendu
  #pridanim id.json dostaneme url kde lze ziskat jeden zaznam  
  def self.target_url 
    site + element_name 
  end
  
  #url na kterem je editacni stranka zadaneho zaznamu (dle id)
  #napr http://demo.flexibee.eu:80/c/demo/adresar/1;edit - pokud toto url otevru v prohlizeci, budu moci dany zaznam editovat
  def self.edit_url id
    
    self.site.to_s  + element_name + "/" + id.to_s + ";edit"
    
  end
  
  
    #url na kterem je view stranka zadaneho zaznamu (dle id)
    #napr http://demo.flexibee.eu:80/c/demo/adresar/1 - pokud toto url otevru v prohlizeci, budu moci dany zaznam zobrazit
  def self.view_url id
    
    self.site.to_s  + element_name + "/" + id.to_s 
    
  end
  
      #url na kterem je pdf stranka zadaneho zaznamu (dle id)
      #napr http://demo.flexibee.eu:80/c/demo/adresar/1.pdf - pokud toto url otevru v prohlizeci, zobrazi se dany zanzam jako pdf (vhodne napr. pro faktury)
  def self.pdf_url id
    
    self.site.to_s  + element_name + "/" + id.to_s  + ".pdf"
    
  end
  
  #najde zaznam akaktualni agendy dle id a tento vrati 
  #je to to same jako find id, ale prida parametry :mode=>:ruby
  def self.find_by_id (id, params={})
     res =  self.find id , :params=>params.merge(self.default_url_params_map)
     
     Rails.logger.debug "received [#{res}]"
     
     
     #v pripade, ze komunikujeme pres json, tak se nam vrati jiny objekt, a to objekt zabaleny v root tagu (napr. adresar, takze bychom museli k datum pristupovat nasledovne: a.adresar.id. v pripade komunikace pres xml pouzijeme a.id)
     #timto opravime co dostaneme tak, aby vraceny objekt vypadal pokazde stejne
     #v pripade, ze vraceny objekt ma jen 1 attribut, tak vratime rovnou hodnotu tohoto attributu
     
     if !res.nil? && res.attributes.length == 1
      res = res.attributes[res.attributes.keys.first] 
     end 
     
     res
     
  end
 
  #vytvori novy zaznam, vrati result (id recordu jako :id)
  #jako arg vyzaduje mapu ktera ma byt vlozena do tagu "winstrom"
  #zaznam vytvari pomoci connection.put
   def self.new_record args={}
    
    tu = self.url_root_path + self.element_name + self.url_params
    
    w = {'winstrom'=> {element_name.dup=> args}}
    
    Rails.logger.debug "sending request [#{args.to_json}]"
    
    result = connection.put tu,  w.to_json, {'Accept'=>'application/json'}
    
    ret=ActiveSupport::JSON.decode( result.body)['winstrom']
    
    Rails.logger.debug "received response #{result.body}"
    
    if ret['success'].nil? or ret['success'] != 'true'
      raise "Chyba pri vytvareni zaznamu #{element_name} #{args} - #{ret}"
    end
    
    r = ret['results'][0]
    r.symbolize_keys!
    r
    
    
  end
  



  
end


# hotovostni doklad:
#w={"winstrom"=>{'pokladni-pohyb'=>{:typDokl=>'2', :varSym=>"100812011",:typPohybuK=>'typPohybu.prijem',:pokladna=>'2',:jakUhrK=>'jakUhrazeno.rucne1',:sumZklCelkem=>222,:sumCelkemMen=>222,:sumZklCelkemMen=>222,:sumOsvMen=>222,:bezPolozek=>true,:mena=>31}}}
#result = conn.put tu,  w.to_json, {'Accept'=>'application/json'}
