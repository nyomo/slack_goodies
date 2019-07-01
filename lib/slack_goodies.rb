require 'slack'
module SlackGoodies
  class Connection
    def initialize
      @slack = Slack::Client.new token: ENV['SLACK_TOKEN']
      chk = self.auth_test
p chk
      if chk["ok"] == false
        @slack = nil
   #    raise ApiKeyPermissionError
      end
    end
    def auth_test
      @slack.auth_test
  
    end
    def check_permissions
      @slack.apps_permissions_request
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
    end
    def users_list 
      return @users if !@users.nil?
      list = @slack.users_list
p list
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
      userdata = @users.select{|u| (!u["deleted"] && /#{email}/ === u["profile"]["email"])}
    end
    def channelname2channeldata(channelname)
      if @channels.nil?
         @channels = self.channel_list
      end
      @channels.each do |k|
        if k["name"] == channelname then
          channeldata = k
        end
      end
    end
  end 
  class ApiKeyPermissionError < StandardError
  end
end
