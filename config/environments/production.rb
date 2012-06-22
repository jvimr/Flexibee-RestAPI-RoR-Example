FlexibeeConnect::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The production environment is meant for finished, "live" apps.
  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Specifies the header that your server uses for sending files
  config.action_dispatch.x_sendfile_header = "X-Sendfile"

  # For nginx:
  # config.action_dispatch.x_sendfile_header = 'X-Accel-Redirect'

  # If you have no front-end server that supports something like X-Sendfile,
  # just comment this out and Rails will serve the files

  # See everything in the log (default is :info)
  # config.log_level = :debug

  # Use a different logger for distributed setups
  # config.logger = SyslogLogger.new

  # Use a different cache store in production
  # config.cache_store = :mem_cache_store

  # Disable Rails's static asset server
  # In production, Apache or nginx will already do this
  config.serve_static_assets = false

  # Enable serving of images, stylesheets, and javascripts from an asset server
  # config.action_controller.asset_host = "http://assets.example.com"

  # Disable delivery errors, bad email addresses will be ignored
  # config.action_mailer.raise_delivery_errors = false

  # Enable threaded mode
  # config.threadsafe!

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify
  
  #zatim v production budeme pouzivat take pripojeni do demo.flexibee.eu, vyuzijeme to na heroku instalaci
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
