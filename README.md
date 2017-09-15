To run project in development please perform steps below:
1) Go to projects folder and run "rvm --create --ruby-version ruby-2.4.1@news_test_task";
2) Run "bundle install";
3) Generate file config/database.yml based on config/database.yml.example ;
4) Run "rake db:create" to create databases;
5) Run "rake db:migrate" ;
6) Run "foreman start".

To fetch news from yandex manually run "rake start_news_grabber".
To add yandex news fetching task into crontab run "whenever --update-crontab --set environment='development'".
