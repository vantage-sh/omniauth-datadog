require 'spec_helper'

RSpec.describe OmniAuth::Strategies::Datadog do
  let(:request) { instance_double('Request', :params => { 'dd_org_name' => 'orgname', 'dd_oid' => 'organizationid', 'site' => 'https://app.datadoghq.com' }) }
  let(:parsed_response) { instance_double('ParsedResponse') }
  let(:response) { instance_double('Response', :parsed => parsed_response) }

  subject do
    OmniAuth::Strategies::Datadog.new({})
  end

  context 'client options' do
    it 'should have correct site' do
      expect(subject.options.client_options.site).to eq('https://app.datadoghq.com')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('oauth2/v1/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('oauth2/v1/token')
    end
  end

  context '#uid' do
    it {
      allow(subject).to receive(:request).and_return(request)
      expect(subject.uid).to eq('organizationid')
    }
  end

  context '#raw_info' do
    it {
      allow(subject).to receive(:request).and_return(request)
      expect(subject.raw_info).to eq({ 'dd_org_name' => 'orgname', 'dd_oid' => 'organizationid', 'site' => 'https://app.datadoghq.com' })
    }
  end

  describe '#callback_url' do
    it 'is a combination of host, script name, and callback path' do
      allow(subject).to receive(:full_host).and_return('https://example.com')
      allow(subject).to receive(:script_name).and_return('/sub_uri')
      expect(subject.callback_url).to eq('https://example.com/sub_uri/auth/datadog/callback')
    end
  end

  describe '#client' do
    it 'adjusts based on the site' do

    end
    
    it 'defaults do the specified site' do

    end
  end
end