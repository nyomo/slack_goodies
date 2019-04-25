require 'slack'
class SlackGoodies
  def initialize()
    @@slack = Slack::Client.new token: ENV['SLACK_TOKEN']
  end
  def auth_test
    @@slack.auth_test
  end
  def channel_list
    list = @@slack.channels_list()
    @@channels = list["channels"]
    while list != nil
      if  list["response_metadata"]["next_cursor"] != ""
        list = @@slack.channels_list(cursor:list["response_metadata"]["next_cursor"])
        @@channels += list["channels"]
      else
        list = nil
      end
    end
    @@channels
  end
end 

