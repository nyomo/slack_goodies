require 'slack_goodies'
require 'vcr'
require 'webmock/rspec'
VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
end
connection = Slack_goodies::Connection.new
describe "Channel名からChannelIDを取得する場合" do
  describe "指定したチャンネル名がpublicチャンネルだった場合" do
    example "チャンネルIDが取得出来る" do
      VCR.use_cassete("channels_list_public") do
        expect { connection.channel_id("xxx-slackgoodies-test1") }
      end
    end
  end
  describe "指定したチャンネル名がprivateチャンネルだった場合" do
    example "チャンネルIDが取得出来る" do
      VCR.use_cassete("channels_list_private") do
      end
    end
  end
  describe "指定したチャンネル名が無かった場合" do
    example "例外を投げる" do
      VCR.use_cassete("channels_list_private") do
      end
    end
  end
end

