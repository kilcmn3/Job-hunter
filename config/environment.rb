require 'bundler'
Bundler.require

require 'active_record'
require 'sqlite3'
require 'pry'
require "tty-prompt"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
DB = {:conn => SQLite3::Database.new("db/development.db")}
require_all 'lib'
