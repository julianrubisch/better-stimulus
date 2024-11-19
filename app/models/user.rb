class User < ApplicationRecord
  has_secure_password

  generates_token_for :email_verification, expires_in: 2.days do
    email
  end

  generates_token_for :password_reset, expires_in: 20.minutes do
    password_salt.last(10)
  end

  encrypts :access_token, :refresh_token

  has_many :sessions, dependent: :destroy
  has_many :events, dependent: :destroy

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, allow_nil: true, length: { minimum: 12 }

  normalizes :email, with: -> { _1.strip.downcase }

  before_validation if: :email_changed?, on: :update do
    self.verified = false
  end

  after_update if: :password_digest_previously_changed? do
    sessions.where.not(id: Current.session).delete_all
  end

  after_update if: :email_previously_changed? do
    events.create! action: "email_verification_requested"
  end

  after_update if: :password_digest_previously_changed? do
    events.create! action: "password_changed"
  end

  after_update if: [:verified_previously_changed?, :verified?] do
    events.create! action: "email_verified"
  end

  def patron?
    identity_data = patreon_client.get_identity("include" => "memberships.campaign", "fields[member]" => "patron_status")

    return false unless identity_data["included"].present?

    identity_data["included"].any? { _1["attributes"]["patron_status"] == "active_patron" && _1["relationships"]["campaign"]["data"]["id"] == Rails.application.credentials.dig(:patreon, :campaign_id).to_s }
  end

  def patreon_client
    @patreon_client ||= PatreonClient.new(access_token)
  end
end
