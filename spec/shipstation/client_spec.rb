require 'spec_helper'

RSpec.describe ShipStation::Client do
  AUTH_KEY = 'some-key'
  AUTH_SECRET = 'some-secret'

  let(:client) { described_class.new(AUTH_KEY, AUTH_SECRET) }
  subject { client }

  describe '#shipments' do
    subject { super().shipments }

    it 'hits the correct API endpoint' do
      expect(described_class).to receive(:get).with('/shipments', anything)
      subject
    end

    it 'attaches the auth' do
      expect(described_class).to receive(:get)
        .with(anything, hash_including({ basic_auth: { password: AUTH_SECRET, username: AUTH_KEY }, verify: false }))
      subject
    end

    it 'sends any options passed' do
      options = { a: 1, b: 2 }
      expect(described_class).to receive(:get).with(anything, hash_including({ query: options }))
      client.shipments(options)
    end
  end
end
