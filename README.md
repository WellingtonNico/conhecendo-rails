# README

* Ruby version:
2.5.0

* System dependencies:
- sqlite3;
- imagemagick; 
- redis;

* How to run the test suite:
after create database, run the command "rails test".

* Tips:
- To run old ruby versions on apple silicon, you should install an old version of
openssl, I tryied using 1.0.2, and then runing command to install ruby with "arch -x86_64"
before the command to install ruby. Ex: arch -x86_64 rbenv install 2.5.0;
- The 'gem pg' does not work with postgresl installed with brew on mac, you should
install other version with libpq already included for the gem to can find the lib,
even setting correct path to run bundle install, it cant find libpq with brew postgres;
- Sidekiq is being used as background job handler, then to start the worker 
use the command bundle "exec sidekiq";


* Addons
Becouse of the addons you must run some commands before run "rails db:migrate":
- "rails g active_record:session_migration";
- "rails g delayed_job:active_record";


