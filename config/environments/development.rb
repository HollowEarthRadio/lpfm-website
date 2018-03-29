LpfmWebsite::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = false

  config.assets.compile = true
  config.assets.precompile += %w(
    template/*
    application.js
    active_admin.js.coffee
    bookman_600.font.js
    cufon-yui.js
    pollstation.js
    active_admin.css.scss
    events.css.scss
    her-ie.css
    her-program.css
    her.css
    her-mobile.css
    hollow.css
    active-admin.css.scss
  )
  config.assets.digest = false
  config.assets.compress = true

  config.paperclip_defaults = {
    storage: :s3,
    s3_credentials: {
      access_key_id: ENV.fetch('S3_KEY'),
      secret_access_key: ENV.fetch('S3_SECRET'),
      s3_region: ENV.fetch('AWS_REGION'),
    }
  }
end
