# coding: utf-8
require 'socket'
require "thread"
require "logger"
require "pry"

def require_helper(path)
  Dir[File.dirname(__FILE__) + "/follower_maze#{path}*.rb"].each { |file| require file }
end

require_helper("/util/")
require_helper("/")

module FollowerMaze
	@@logger = Logger.new(STDOUT)
end

