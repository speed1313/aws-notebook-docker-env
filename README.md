# aws-notebook-docker-env
Docker environment for using jupyter notebook with aws-braket.
You can run in VSCode by using remote container feature

- [x]  Dockerfileによる環境の用意
- [x]  VScode上でnote bookを操作するための .devcontainerの設定
- [x]  ローカル - コンテナ間のネットワーク接続
- [x]  編集したnotebookをローカルに保存する機能
- [x]  aws credentialsをコンテナ立ち上げ時のみロードする機能
- [ ]  note bookからaws braket apiを呼び出す

現在の問題

ipykernelが~/.aws/ の情報を読み取ってくれないため, notebookからbraket apiが呼べない.
ノートブックからでなければコンテナからでもapiが呼べている. つまりターミナルから直接python3 コマンドで実行すればapiを呼べる.
## Requires
- docker
- vscode
- vscode remote container extention package
-

## How to use
1. [aws-mfa](https://qiita.com/ogady/items/c17ffe8f7c8e15b15f77)で[sample]というプロファイルに認証情報を書き込む.
[sample]の内容は以下の通り
``` ~/.aws/credentials
...
...
[sample]
assumed_role = False
aws_access_key_id = ****
aws_secret_access_key = ****
aws_session_token = ****
expiration = 2022-03-15 19:16:28
```
~/.aws/configも以下のように付け加える.
```~/.aws/config
...
[sample]
region = us-east-1
output = json
```

2. このレポジトリをクローン
```
git clone https://github.com/speed1313/aws-notebook-docker-env
```

3. VSCodeで開く
```
cd aws-notebook-docker-env
code .
```
4. remote container in Dockerを開始
5. jupyter拡張機能をインストール
6. ターミナルでaws credentialsのプロファイル指定
```
$  export AWS_PROFILE=sample
```
7. ipynbファイルを開き, python3 ipykernelを選択

## Reference
https://github.com/sergiomtzlosa/docker-aws-braket