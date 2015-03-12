# coding: utf-8
require 'socket'
require "thread"
require "logger"
require "ostruct"
require "optparse"

def require_helper(path)
  Dir[File.dirname(__FILE__) + "/follower_maze#{path}*.rb"].each { |file| require file }
end

require_helper("/")

module FollowerMaze
  extend self
  unless ENV["RB_ENV"] == "test"
    file_name = "#{Time.now}-follower_maze.log"
    File.open(file_name, "w+")

    $logger = Logger.new(file_name)
  end
end

