require 'slack-ruby-client'
module SlackGoodies
  class Connection
    def initialize
=begin
      chk = self.auth_test
      if chk["ok"] == false
        raise ApiKeyPermissionError.exception(chk["error"])
      end
=end
      @slack = nil 
      @channels = nil
    end
    def slack_client
      Slack.configure do |config|
        config.token = ENV['SLACK_API_USER_TOKEN']
      end
      Slack::Web::Client.new
    end
    def auth_test
      @slack.auth_test
    end
    def channel_list
      slack = slack_client
      return @channels if !@channels.nil?
      @channels = slack.channels_list
    end
    def users_list 
      return @users if !@users.nil?
      list = @slack.users_list
      @users = list["members"]
      while list != nil
        if  list["response_metadata"]["next_cursor"] != ""
          list = @slack.users_list(cursor:list["response_metadata"]["next_cursor"])
          @users += list["members"]
        else
          list = nil
        end
      end
      @users
    end
    def email2userdata(email)
      if @users.nil?
         @users = self.users_list
      end
      @users.select{|u| (!u["deleted"] && /#{email}/ === u["profile"]["email"])}
    end
    def channelname2channeldata(channelname)
      channeldata = nil
      if @channels.nil?
         @channels = self.channel_list
      end
      @channels.each do |k|
        if k["name"] == channelname then
          channeldata = k
        end
      end
      channeldata
    end
    def channels_invite(options={})
      @slack.channels_invite(options)
    end
  end 
  class ApiKeyPermissionError < StandardError
    def initialize(message)
      super(message)
    end
    def exeception(message)
      self.new(message)
    end
  end
end
