Rails.application.config.after_initialize do
  Sitepress::SiteController.include(Sitepress::HttpCaching)
end

module Sitepress::HttpCaching
  extend ActiveSupport::Concern

  included do
    before_action do
      fresh_when current_resource.asset.updated_at if current_resource.data["cache"]
    end
  end
end
