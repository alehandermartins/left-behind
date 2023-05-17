# frozen_string_literal: true

class SessionsController < ApplicationController

  GOOGLE_AUTH_TOKEN_URL = "https://www.googleapis.com/oauth2/v4/token"
  GOOGLE_AUTH_PROFILE_URL = "https://openidconnect.googleapis.com"
  GOOGLE_AUTH_PROFILE_ENDPOINT = "/v1/userinfo"

  GOOGLE_AUTH_CLIENT_ID = ENV["GOOGLE_AUTH_CLIENT_ID"]
  GOOGLE_AUTH_SECRET = ENV["GOOGLE_AUTH_SECRET"]

  def new; end

  def create
    if (error = validate_callback_response.presence)
      render_error_response(error)
    else
      UserIdentifier.new(current_user).identify(user_profile)

      redirect_to root_path
    end
  rescue StandardError => e
    render_error_response("failed to connect")
  end

  def redirect_to_provider
    redirect_to(sign_in_url, allow_other_host: true)
  end

  private

  def user_profile
    @user_profile ||= user_profile_request
  end

  def sign_in_url
    "https://accounts.google.com/o/oauth2/v2/auth?#{google_auth_params.to_query}"
  end

  def callback_url
    "#{request.base_url}#{session_path}"
  end

  def access_token_response
    @access_token_response ||= exchange_token
  end

  def google_auth_params
    {
      client_id: GOOGLE_AUTH_CLIENT_ID,
      response_type: "code",
      scope: "openid email profile",
      redirect_uri: callback_url,
      state: session[:_csrf_token],
      nonce: SecureRandom.hex,
      hd: "leftbehind.com"
    }
  end

  def exchange_token_params
    {
      code: params[:code],
      client_id: GOOGLE_AUTH_CLIENT_ID,
      client_secret: GOOGLE_AUTH_SECRET,
      redirect_uri: callback_url,
      grant_type: "authorization_code"
    }
  end

  def exchange_token
    response =
      Faraday.post(GOOGLE_AUTH_TOKEN_URL, exchange_token_params.to_json) do |req|
        req.headers["Accept"] = "application/json"
        req.headers["Content-Type"] = "application/json"
      end

    body = JSON.parse(response.body)
    puts body

    raise GoogleAuthentication::ServiceError, "failed to connect" if !response.success? && body["error"].blank?

    body
  end

  def user_profile_connection
    Faraday.new(url: GOOGLE_AUTH_PROFILE_URL) do |conn|
      conn.options.timeout = 2
      conn.options.open_timeout = 2
      conn.request :retry, max: 2
      conn.adapter Faraday.default_adapter
    end
  end

  def user_profile_request
    response =
      user_profile_connection.get(GOOGLE_AUTH_PROFILE_ENDPOINT) do |req|
        req.headers["Authorization"] = "Bearer #{access_token_response['access_token']}"
      end

    body = JSON.parse(response.body)
    puts body

    raise GoogleAuthentication::ServiceError, "failed to connect" if !response.success? && body["error"].blank?

    body
  end

  def validate_callback_response
    return params[:error] if params[:error].present?
    return "missing `code` parameter" if params[:code].blank?
    return "invalid authenticity token" unless valid_authenticity_token?(session, params[:state])
    if access_token_response["error"].present?
      return "#{access_token_response['error_description']} (code: #{access_token_response['error']})"
    end
    return "#{user_profile['error_description']} (code: #{user_profile['error']})" if user_profile["error"].present?
    return "invalid user ID" if user_profile["sub"].blank?
    return "user not verified" unless user_profile["email_verified"]

    nil
  end

  def render_error_response(message)
    flash.now[:error] = "Service Error: #{message}"
    render :new
  end
end
