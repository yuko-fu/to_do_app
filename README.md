# README
モデル名 |カラム名         |データ型 |
|---------|----------------|---------|
|User     |id              |integer  |
|         |name            |string   |
|         |email           |string   |
|         |password        |string   |
|         |password_digest |string  |



|モデル名 |カラム名  |データ型 |
|---------|----------|---------|
|Task     |id        |integer  |
|         |task_name |string   |
|         |content   |string   |
|         |status    |string   |
|         |limit_day |date     |
|         |user_id   |integer  |


モデル名 |カラム名    |データ型 |
|---------|-----------|---------|
|Label    |id         |integer  |
|         |label_name |string   |
|         |task_id    |integer  |


Herokuへのデプロイ手順
１　heroku create でherokuに新しいアプリケーションを作成する
２　gem 'net-smtp'
　　gem 'net-imap'
　　gem 'net-pop'
　　をGemfileに追加し、bundle installを実行する
３　git add .
    git commit -m"コミット名"
    でコミットする
４　heroku buildpacks:set heroku/ruby
　　heroku buildpacks:add --index 1 heroku/nodejs
　　heroku addons:create heroku-postgresql
　　を追加で実行する
５　git push heroku masterまたはgit push heroku ブランチ名:masterでデプロイする
