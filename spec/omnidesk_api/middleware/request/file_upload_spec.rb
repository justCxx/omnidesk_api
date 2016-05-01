require 'spec_helper'

describe OmnideskApi::Middleware::Request::FileUpload do
  describe '.call' do
    let(:middleware) { described_class.new(-> (env) { env }) }
    let(:upload_file) { 'spec/files/gundamcat.png' }

    let(:params) do
      { message: { content: 'Test message', attachments: [upload_file] } }
    end

    subject { middleware.call(body: params)[:body][:message][:attachments] }

    it { is_expected.to all be_a Faraday::UploadIO }

    context 'when params is array' do
      let(:params) do
        { messages: [
          { content: 'message1', attachments: [upload_file] },
          { content: 'message2', attachments: [upload_file, upload_file] }] }
      end

      subject do
        body = middleware.call(body: params)[:body]
        body[:messages].map { |m| m[:attachments] }.flatten
      end

      it { is_expected.to all be_a Faraday::UploadIO }
    end

    context 'when attachments already is a UploadIO' do
      let(:params) do
        { message: {
          attachments: [Faraday::UploadIO.new(upload_file, 'image/png')] } }
      end

      subject do
        middleware.call(body: params)[:body][:message][:attachments]
      end

      it { is_expected.to all be_a Faraday::UploadIO }
    end

    context 'when params no has key :attachments' do
      let(:params) do
        { message: { content: 'Test message', thumbnails: [upload_file] } }
      end

      subject { middleware.call(body: params)[:body][:message][:thumbnails] }

      it { is_expected.to all be_a String }
    end
  end
end
