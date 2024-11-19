Rails.application.config.after_initialize do
  Sitepress::SiteController.class_eval do
    # TODO other way round: authenticate _IF_ required
    # skip_before_action :authenticate
  end
end
