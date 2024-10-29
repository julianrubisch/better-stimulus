class Session < ApplicationRecord
  belongs_to :user

  before_create do
    self.user_agent = Current.user_agent
    self.ip_address = Current.ip_address
  end

  after_create  { user.events.create! action: "signed_in" }
  after_destroy { user.events.create! action: "signed_out" }
end
