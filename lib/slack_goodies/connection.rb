require 'slack-ruby-client'
module SlackGoodies
  class Connection
    def initialize
      Slack.configure do |config|
        config.token = ENV['SLACK_API_USER_TOKEN']
      end
      @slack = Slack::Web::Client.new
      chk = self.auth_test
      if chk["ok"] == false
        raise ApiKeyPermissionError.exception(chk["error"])
      end
      @channels = nil
    end
    def auth_test
      @slack.auth_test
    end
    def channel_list
      return @channels if !@channels.nil?
      list = @slack.channels_list
      @channels = list["channels"]
      while list != nil
        if  list["response_metadata"]["next_cursor"] != ""
          list = @slack.channels_list(cursor:list["response_metadata"]["next_cursor"])
          @channels += list["channels"]
        else
          list = nil
        end
      end
      @channels
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
    #channels_invite(channel:channel_data['id'],user:user['id'],user_name:user['name'],dryrun: dryrun)
    #users+=(list["members"].select{|u| (!u["deleted"] && /#{mailaddr_regexp}/ === u["profile"]["email"])})
      channel_data = @slack.channels_info(options)
      if(channel_data["channel"]["members"].include?(options[:user]))
        return false
      else
        begin
        @slack.channels_invite(options)
        rescue => e
          return e.message
        end
      end
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
