require 'optparse'
class  Cli
  def initialize
      option = {
        dryrun: true,
      }
      OptionParser.new do |opt|
        opt.banner = "Usage:ほげほげ"
        opt.on('--regexp VALUE',Array,'正規表現でユーザのメールアドレスを指定')	{|v| option[:r] = v}
				opt.on('--channel VALUE','チャンネル名を指定'){|v| option[:c] = v}
				#opt.on('--filename FILENAME','ファイルからユーザのメールアドレスを読み込む'){|v| option[:f] = v}
        #opt.on('--[no-]dryrun',"dryrunにする(default: #{option[:dryrun]})"){|v| option[:dryrun] = v}
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
      p option
  end
end
