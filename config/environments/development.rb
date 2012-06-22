FlexibeeConnect::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin
  
  
  
    #nastaveni pristupu do flexibee
  #vpodstate jde o rozepsane url:
  #http://demo.flexibee.eu:80/c/demo/
  config.flexibee_host = "demo.flexibee.eu"
  config.flexibee_port = "80"
  config.flexibee_proto = "http"
  config.flexibee_firma = "demo"

  #uzivatel a heslo pro pripojeni

  config.flexibee_user = "winstrom"
  config.flexibee_password = "winstrom"

  config.flexibee_fakt_primUcet = "code:321001"
  config.flexibee_fakt_protiUcet="code:602001"
  config.flexibee_fakt_typUcOp = "code:TRŽBA SLUŽBY"
  config.flexibee_fakt_bankovniUcet="code:BANKOVNÍ ÚČET"
  config.flexibee_fakt_clenDph="code:01-02"
  config.flexibee_fakt_formaUhrK_prevod="formaUhr.prevod"
  config.flexibee_fakt_formaUhrK_hotove="formaUhr.hotove"

  config.flexibee_hotUhrada_pokladna="code:DOMA"
  config.flexibee_hotUhrada_typDokl="code:TYP DOMA"

  
  
end

