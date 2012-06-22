
#trida pro pristup do Flexibee, casti "adresar"
class FbAdresa < FbConnect

  #budeme pristupovat do evidence "adresar"
  self.element_name = "adresar"
  self.url_params = "?mode=ruby"
  

  
  #najit jednoho
  #FbStudent.find "(jmeno begins 'I')", :params => { :mode => 'ruby' }
  #vylistovat vsechny:
  #FbStudent.find( '(id>0)' , :params=>{:mode=>'ruby', :detail=>"full"}).kontakt <- pole kontaktu



   #url na kterem jsou vsechny faktury zadane firmy (id = id firmy v evidenci "adresar")
  def self.faktury_url id
    
    self.site.to_s + "faktura-vydana/(firma=#{id.to_s})"
    
  end
  
  #vytvori novy zaznam "adresa" ve flexibee. args je mapa, ktera obsahuje polozky ktere chceme nasatavit (napr. {:nazev=>'FlexiBee s.r.o.'})
  def self.new_adresa args={}
    
    default_args = {:stat=>"code:CZ", :poznam=>"Automaticky vytvoreno v estu dne #{Date.today.to_s}", :postovniShodna=>true}
    
    self.new_record default_args.merge( args)
  end
  


  
   #zjednoduseni pristupu k loggeru - pro interni pouziti
   def self.logger 
     RAILS_DEFAULT_LOGGER
  end
  
  
  
  
  
  
  #FbDemo.new_adresa( {:nazev => 'jin',:mobil=>'nokia', :stat=>"code:CZ" ,:poznam=>'Automaticky vytvoreno v estu\nnn', :ulice=>'test', :mesto=>'mesto', :psc=>'43233', :email=>'dlouhej', :faUlice=>'faulice', :faMesto=>'famesto', :faPsc=>'1234', :faJmenoFirmy=>'fa', :postovniShodna=>false}) 


  

end
