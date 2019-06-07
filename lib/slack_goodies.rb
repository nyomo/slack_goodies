require 'slack'
class SlackGoodies
  def initialize
    @slack = Slack::Client.new token: ENV['SLACK_TOKEN']
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
    return @channels
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
    userdata = @users.select{|u| (!u["deleted"] && /#{email}/ === u["profile"]["email"])}
  end
end 
