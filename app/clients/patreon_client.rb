# frozen_string_literal: true

class PatreonClient
  include HTTParty
  base_uri "https://www.patreon.com/api/oauth2/v2"

  def initialize(access_token)
    @options = {
      headers: {
        "Authorization" => "Bearer #{access_token}",
      }
    }
  end
  # TODO obtain membership/campaign info
  # probably through a client
  # https://docs.patreon.com/?shell#get-api-oauth2-v2-campaigns
  # GET /api/oauth2/v2/campaigns
  # Requires the campaigns scope. Returns a list of Campaigns owned by the authorized user.


  def get_identity(**args)
    response = self.class.get("/identity?#{URI.encode_www_form(args)}", @options)
    handle_response(response)
  end

  def get_campaign_members(campaign_id: Rails.application.credentials.patreon.campaign_id, **args)
    response = self.class.get("/campaigns/#{campaign_id}/members?#{URI.encode_www_form(args)}", @options)

    handle_response(response)
  end

  # Private method to handle API responses
  private

  def handle_response(response)
    case response.code
    when 200, 201
      response.parsed_response
    when 401
      raise "Unauthorized: Invalid access token."
    when 404
      raise "Not Found: #{response.parsed_response["message"]}"
    else
      raise "Error: #{response.code} - #{response.parsed_response["message"]}"
    end
  end
end
