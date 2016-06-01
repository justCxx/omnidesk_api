require 'spec_helper'

describe OmnideskApi do
  before do
    OmnideskApi.reset!
  end

  after do
    OmnideskApi.reset!
  end

  it 'sets defaults' do
    OmnideskApi::Configurable.keys.each do |key|
      actual = OmnideskApi.instance_variable_get(:"@#{key}")
      default = OmnideskApi::Default.send(key)
      expect(actual).to eq(default)
    end
  end

  describe '.client' do
    it 'creates an OmnideskApi::Client' do
      expect(OmnideskApi.client).to be_kind_of OmnideskApi::Client
    end

    it 'caches the client when the same options are passed' do
      expect(OmnideskApi.client).to eq(OmnideskApi.client)
    end

    it 'returns a fresh client when options are not the same' do
      client = OmnideskApi.client

      OmnideskApi.password = 'i10veruby'

      client_two = OmnideskApi.client
      client_three = OmnideskApi.client

      expect(client).not_to eq(client_two)
      expect(client_two).to eq(client_three)
    end
  end

  describe '.configure' do
    OmnideskApi::Configurable.keys.each do |key|
      it "sets the #{key.to_s.tr('_', ' ')}" do
        OmnideskApi.configure do |config|
          config.send("#{key}=", key)
        end
        expect(OmnideskApi.instance_variable_get(:"@#{key}")).to eq(key)
      end
    end
  end
end
