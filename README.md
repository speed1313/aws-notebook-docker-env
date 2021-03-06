# aws-notebook-docker-env
Docker image to run the AWS Braket on Jupyter from local.

- You can access to the Jupyter notebook on Container through http://localhost:8888/?token=(token_id)
- Changes to files under the example directory are also saved locally.
- Even if mfa authentication has already been set up, you can throw bracket jobs by using the package "aws-mfa",
- This environment contains aws-cli,amazon-braket-sdk, boto3, and popular python package.


## Requires
- Docker Desktop [How to install Docker Desktop](https://docs.docker.com/get-docker/)


## How to use
1. [aws-mfaの使い方](https://qiita.com/ogady/items/c17ffe8f7c8e15b15f77)を参考に/.aws/credentialsに[sample]というプロファイルに認証情報を書き込む.

```
# ローカルでaws-mfaを取得
$ pip3 install aws-mfa
# インストールされてるか確認
$ aws-mfa -h
# 発行したアクセスキーでaws cliの設定を行う
$ aws configure --profile sample-long-term
$ aws configure --profile sample
$ aws-mfa --profile sample --device arn:aws:iam::123456788990:mfa/IAMユーザー名
# プロファイルが生成されているか確認
$ cat ~/.aws/credentials

# --device arn:aws:iam::123456788990:mfa/IAMユーザー名 の指定が面倒なら以下のように追記
$vim ~/.aws/credentials
[sample-long-term]
aws_access_key_id = XXXXXXXXXXXXXXXXXXXX
aws_secret_access_key = XXXXXXXXXXXXXXXXXXXX
aws_mfa_device = arn:aws:iam::123456788990:mfa/IAMユーザー名 # ←追記
# するとdevice情報を省略できる.
$  aws-mfa --profile sample

```
最終的な
~/.aws/credentialsの[sample]の内容は以下の通りになっているはず.
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
また, ~/.aws/configも以下のように付け加えておく.
```~/.aws/config
...
[sample]
region = us-east-1
output = json
```

- なお, 認証期限が切れたら, 再び```$  aws-mfa --profile sample```で認証情報を設定し直す.


2. このリポジトリをクローン
```
git clone https://github.com/speed1313/aws-notebook-docker-env
```

3. docker-composeファイルを元にコンテナを立ち上げる
```
cd aws-notebook-docker-env
docker compose build
docker compose up
```

4. ターミナルに出力されるtokenを元に, ブラウザでnotebookを開く. ここで, ポート番号を8888にすることに注意(local:remoteが8888:8889と指定してある.)
```
...
aws-braket-notebook  |     To access the notebook, open this file in a browser:
aws-braket-notebook  |         file:///root/.local/share/jupyter/runtime/nbserver-1-open.html
aws-braket-notebook  |     Or copy and paste one of these URLs:
aws-braket-notebook  |         http://83492e6e0fe8:8889/?token=661111ae412d8bcfa9179fad665096ec128793b3bd5ca44a
aws-braket-notebook  |      or http://127.0.0.1:8889/?token=661111ae412d8bcfa9179fad665096ec128793b3bd5ca44a

```

5. Stops containers and removes containers, networks, volumes, and images created by up.
```
docker compose down
```

## Reference
https://github.com/sergiomtzlosa/docker-aws-braket
http://man.hubwiz.com/docset/Boto3.docset/Contents/Resources/Documents/guide/configuration.html
