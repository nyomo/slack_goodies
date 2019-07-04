# Slackのなんか便利なコマンド


## インストール方法

```
gem install specific_install
gem specific_install -l 'https://github.com/nyomo/slack_goodies.git'
```

## 使い方
### SlackのAPI tokenを用意する
  1. https://api.slack.com/slack-apps にアクセス
  1. Create a Slack APP ボタンを押す
  1. AppNameに好きな名前を入れる
  1. Development Slack workspace にこのコマンドで操作したいワークスペースを選ぶ
  1. Create Appを押す
  1. Permissionsを選ぶ
  1. Scopesはchannnels:read channels:write chat:write:bot users:read users:read.email を選ぶ
  1. Save Changesを押す
  1. Insatall App to Workspaceを押す
  1. Installを押す
  1. OAuth Access Tokenをコピーする
  1. SlackGoodiesを使うシェルのSLACK_TOKEN環境変数に↑を入れる
 
### channel_inviter
```
Usage: channel_inviter --regexp 'mailaddress' --channel 'channelname' [--no-dryrun]
        --regexp VALUE               正規表現でユーザのメールアドレスを指定
        --channel VALUE              チャンネル名を指定
        --filename FILENAME          ファイルからユーザのメールアドレスを読み込む(未実装)
        --[no-]dryrun                dryrunにする(default: true)
```
 - 最低限　regexpオプションとchannelオプションを指定する必要がある
 - no-dryrunを指定しない場合実際には実行されない 
