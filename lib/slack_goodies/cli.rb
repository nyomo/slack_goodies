require 'optparse'
module SlackGoodies
  class  Cli
    def initialize
        @options = {
          dryrun: true,
          varbose: false,
        }
        OptionParser.new do |opt|
          opt.banner = "Usage:ほげほげ"
          opt.on('--regexp VALUE','正規表現でユーザのメールアドレスを指定')	{|v| @options[:mail] = v}
  				opt.on('--channel VALUE','チャンネル名を指定'){|v| @options[:channel] = v}
  				opt.on('--filename FILENAME','ファイルからユーザのメールアドレスを読み込む'){|v| @options[:filename] = v}
          opt.on('--[no-]verbose',"実行時にdryrunと同じ程度の実行内容の出力を行う(default: #{@options[:verbose]})"){|v| @options[:verbose] = v}
          opt.on('--[no-]dryrun',"dryrunにする(default: #{@options[:dryrun]})"){|v| @options[:dryrun] = v}
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
          @help = opt.help
        end
        self.check_opt
    end
    def check_opt
      #使うアプリ毎に必須オプションなどを設定する
      if self.get(:channel).nil?
        puts "チャンネル名の指定が必要です"
        puts self.help
        exit
      end
      if self.get(:mail).nil?
        puts "メールアドレスの指定が必要です"
        puts self.help
        exit
      end
    end
    def get(name)
      @options[name]
    end
    def help
      @help
    end
  end
end
