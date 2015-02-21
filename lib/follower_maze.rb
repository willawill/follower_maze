# coding: utf-8
require 'socket'
require "thread"
require "logger"
require "ostruct"
require "optparse"
require "pry"
require 'ruby-prof'

def require_helper(path)
  Dir[File.dirname(__FILE__) + "/follower_maze#{path}*.rb"].each { |file| require file }
end

require_helper("/")

module FollowerMaze
  extend self
  file_name = "#{Time.now}-follower_maze.log"
  File.open(file_name, "w+")

  $logger = Logger.new(file_name)
end

