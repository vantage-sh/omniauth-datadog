require 'omniauth/strategies/oauth2'

module Omniauth
  module Strategies
    class Datadog
      VALID_DOMAINS = [
        'datadoghq.eu',
        'datadoghq.com'
      ]

      option :client_options, 
        site: 'https://app.datadoghq.com',
        authorize_url: 'oauth2/v1/authorize',
        token_url: 'oauth2/v1/token',
        auth_scheme: :request_body
      
      option :pkce, true

      uid do
        raw_info['dd_oid']
      end

      info do
        raw_info
      end

      def raw_info
        @raw_info ||= request.params.slice('dd_org_name', 'dd_oid', 'site')
      end

      def callback_url
        full_host + script_name + callback_path
      end

      def build_access_token
        verifier = request.params["code"]
        client.auth_code.get_token(verifier, {:redirect_uri => callback_url}.merge(token_params.to_hash(:symbolize_keys => true)), deep_symbolize(options.auth_token_params))
      end

      # Datadog has a few different domains.
      # Based on the request set the appropriate site.
      def client
        client_options = options.client_options
        client_options['site'] = request.params['site'] if request.params['site'] && VALID_DOMAINS.any? { |d| request.params['site'].end_with?(d) }
        ::OAuth2::Client.new(options.client_id, options.client_secret, deep_symbolize(client_options))
      end    
    end
  end
end
