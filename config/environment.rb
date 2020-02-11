require 'bundler'
Bundler.require

require 'active_record'
require 'sqlite3'
require 'pry'

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'
