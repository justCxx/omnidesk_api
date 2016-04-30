require 'spec_helper'

describe OmnideskApi::Connection do
  before do
    OmnideskApi.api_endpoint = 'http://example.omnidesk.ru/api'
    stub_request(:any, /example.omnidesk.ru/).to_return(stub_response)
  end

  let(:stub_response) do
    {
      status: 200,
      body: JSON.dump(message: { content: 'I need help!' }),
      headers: { content_type: :json }
    }
  end

  describe '.get' do
    it { expect(OmnideskApi.get('cases')).to be }
  end

  describe '.post' do
    it { expect(OmnideskApi.post('cases')).to be }
  end

  describe '.put' do
    it { expect(OmnideskApi.put('cases')).to be }
  end

  describe '.patch' do
    it { expect(OmnideskApi.patch('cases')).to be }
  end

  describe '.delete' do
    it { expect(OmnideskApi.delete('cases/1')).to be }
  end

  describe '.head' do
    it { expect(OmnideskApi.head('cases')).to be }
  end

  describe '.last_response' do
    it 'should eq to the last response' do
      response = OmnideskApi.get('cases/1')
      expect(response).to eq OmnideskApi.last_response.body
    end
  end
end
