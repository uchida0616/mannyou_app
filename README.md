# DB情報
## Task
columm | data
------------ | -------------
title | string
content | text
## User
columm | data
------------ | -------------
name | string
email | string
password_digest | string
## Label
columm | data
------------ | -------------
label_name | string
task_id | integer
# Herokuへのデプロイ手順
* Herokuに新しいアプリケーションを作成する  

<code>heroku create</code>  
* アセットプリコンパイルをする  

<code>rails assets:precompile RAILS_ENV=production</code>
* コミットする  

<code>git add -A</code>
<code>git commit -m "init"</code>  
* Heroku buildpackを追加する  

<code>heroku buildpacks:set heroku/ruby</code>
* Herokuにデプロイをする  

<code>git push heroku master</code>
