require 'optparse'
module SlackGoodies
  class  Cli
    def initialize
        @options = {
          dryrun: true,
        }
        OptionParser.new do |opt|
          opt.banner = "Usage:ほげほげ"
          opt.on('--regexp VALUE',Array,'正規表現でユーザのメールアドレスを指定')	{|v| @options[:r] = v}
  				opt.on('--channel VALUE','チャンネル名を指定'){|v| @options[:channel] = v}
  				opt.on('--filename FILENAME','ファイルからユーザのメールアドレスを読み込む'){|v| @options[:filename] = v}
          opt.on('--[no-]dryrun',"dryrunにする(default: #{option[:dryrun]})"){|v| @options[:dryrun] = v}
          begin
            opt.parse!(ARGV)
          rescue OptionParser::InvalidOption=>error
            STDERR.puts error.args.join + "は指定出来ません"
            puts opt.help 
            exit
          rescue OptionParser::MissingArgument=>error
            STDERR.puts error.args.join + "にはオプション引数が必要です"
            puts opt.help 
            exit
          end
        end
        p @options
    end
  end
end
