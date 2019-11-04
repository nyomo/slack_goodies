require 'slack_goodies'
require 'vcr'
require 'webmock/rspec'
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end
describe SlackGoodies::Connection do
   it "public channelの一覧が取得出来る" do
      slack_api_mock = double("Slack API")
      allow(slack_api_mock).to receive(:channels_list)
      connection = SlackGoodies::Connection.new
      allow(connection).to receive(:slack_client).and_return(slack_api_mock)
      expect { connection.channel_list }.not_to raise_error
   end
end

