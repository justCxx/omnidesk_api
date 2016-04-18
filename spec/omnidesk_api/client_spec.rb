require 'spec_helper'

describe OmnideskApi::Client do
  before do
    OmnideskApi.reset!
  end

  after do
    OmnideskApi.reset!
  end

  context 'module configuration' do
    before do
      OmnideskApi.reset!
      OmnideskApi.configure do |config|
        OmnideskApi::Configurable.keys.each do |key|
          config.send("#{key}=", "Some #{key}")
        end
      end
    end

    after do
      OmnideskApi.reset!
    end

    it 'inherits the module configuration' do
      client = OmnideskApi::Client.new
      OmnideskApi::Configurable.keys.each do |key|
        expect(client.instance_variable_get(:"@#{key}")).to eq("Some #{key}")
      end
    end

    context 'with class level configuration' do
      let(:opts) do
        { login: 'ruby_developer',
          password: 'i10veruby' }
      end

      it 'overrides module configuration' do
        client = OmnideskApi::Client.new(opts)
        expect(client.instance_variable_get(:"@login")).to eq('ruby_developer')
        expect(client.instance_variable_get(:"@password")).to eq('i10veruby')
        expect(client.per_page).to eq(OmnideskApi.per_page)
      end

      it 'can set configuration after initialization' do
        client = OmnideskApi::Client.new
        client.configure do |config|
          opts.each do |key, value|
            config.send("#{key}=", value)
          end
        end

        expect(client.instance_variable_get(:"@login")).to eq('ruby_developer')
        expect(client.instance_variable_get(:"@password")).to eq('i10veruby')
        expect(client.per_page).to eq(OmnideskApi.per_page)
      end

      it 'masks password on inspect' do
        client = OmnideskApi::Client.new(opts)
        inspected = client.inspect
        secret_data = inspected.scan(/@password=\".*?\"/).first
        expect(secret_data).not_to include('i10veruby')
        expect(inspected).not_to include('i10veruby')
      end
    end
  end
end
