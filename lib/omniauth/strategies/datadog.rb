module OmniAuth
  module Strategies
    class Datadog < OmniAuth::Strategies::OAuth2
      CLIENT_OPTIONS = {
        site: 'https://app.datadoghq.com',
        authorize_url: 'oauth2/v1/authorize',
        token_url: 'oauth2/v1/token',
        auth_scheme: :request_body
      }

      VALID_DOMAINS = [
        'datadoghq.eu',
        'datadoghq.com'
      ]

      option :client_options, CLIENT_OPTIONS
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
        full_host + callback_path
      end

      def build_access_token
        verifier = request.params["code"]
        client.auth_code.get_token(verifier, {:redirect_uri => callback_url}.merge(token_params.to_hash(:symbolize_keys => true)), deep_symbolize(options.auth_token_params))
      end

      # Datadog has a few different domains.
      def client
        client_options = options.client_options
        client_options['site'] = request.params['site'] if request.params['site'] && VALID_DOMAINS.any? { |d| request.params['site'].end_with?(d) }
        ::OAuth2::Client.new(options.client_id, options.client_secret, deep_symbolize(client_options))
      end
    end
  end
end
