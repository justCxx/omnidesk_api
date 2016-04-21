require 'spec_helper'

describe OmnideskApi::Client::Cases do
  describe '.cases' do
    it 'response is a Hash' do
      response = OmnideskApi.client.cases(limit: 2)
      expect(response).to be_a(Hash)
    end

    it 'get cases' do
      response = OmnideskApi.client.cases
      expect(response).to be
    end

    context 'with options' do
      it 'get cases with limit' do
        response = OmnideskApi.client.cases(limit: 5)
        expect(response.to_a.size).to eq 6
      end

      it 'get open cases only' do
        response = OmnideskApi.client.cases(status: :open)
        statuses = response.to_a[0...-1].map { |_, x| x['case']['status'] }.uniq
        expect(statuses).to eq ['open']
      end
    end
  end

  describe '.update_case' do
    let(:case_id) { 2_364_822 }
    let(:subject) { "OmnideskApi spec. Test subject changed at #{Time.now}" }
    let(:options) do
      { 'case' => { subject: subject } }
    end

    it 'update_case' do
      response = OmnideskApi.client.update_case(case_id, options)
      expect(response['case']['subject']).to eq subject
    end
  end

  describe '.spam_case' do
    let(:case_id) { 2_364_822 }

    before do
      OmnideskApi.client.restore_case(case_id)
    end

    it 'mark case as spam' do
      response = OmnideskApi.client.spam_case(case_id)
      expect(response['case']['spam']).to eq true
    end
  end

  describe '.create_message' do
    let(:case_id) { 2_364_822 }
    let(:message) do
      { content: "#{Time.now}. OmnideskApi spec. Create message" }
    end

    it 'create message' do
      response = OmnideskApi.client.create_message(case_id, message: message)
      expect(response).to be
    end

    context 'with attachments' do
      let(:message) do
        {
          content: "#{Time.now}. OmnideskApi spec. Create message with attach",
          attachments: [Faraday::UploadIO.new('tmp/gundamcat.png', 'image/png')]
        }
      end

      it 'create message with attachment' do
        response = OmnideskApi.client.create_message(case_id, message: message)
        expect(response['message']['attachments']).not_to be_empty
      end
    end
  end

  describe '.create_note' do
    let(:case_id) { 2_364_822 }
    let(:note) do
      { content:  "#{Time.now}. OmnideskApi spec. Create note" }
    end

    it 'create note' do
      response = OmnideskApi.client.create_note(case_id, note: note)
      expect(response['message']['note']).to eq true
    end

    context 'with options' do
      let(:note) do
        { content:  "#{Time.now}. OmnideskApi spec. Create note",
          note_group_id: 13_657 }
      end

      it 'for group' do
        response = OmnideskApi.client.create_note(case_id, note: note)
        expect(response['message']['note']).to eq true
      end
    end
  end
end
