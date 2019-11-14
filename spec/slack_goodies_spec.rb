require 'slack_goodies'
require 'vcr'
require 'webmock/rspec'
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end
describe SlackGoodies::Connection do
   it "public channelの一覧が取得出来る" do
      connection = SlackGoodies::Connection.new
      VCR.use_cassette("channels_list") do
        expect { connection.channel_list }.not_to raise_error
      end
   end
end

