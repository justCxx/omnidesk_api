require 'spec_helper'

describe OmnideskApi::Configurable do
  describe '.api_endpoint' do
    before do
      OmnideskApi.api_endpoint = 'https://mydomain.omnidesk.ru'
    end

    it { expect(OmnideskApi.api_endpoint).to end_with '/' }
  end
end
