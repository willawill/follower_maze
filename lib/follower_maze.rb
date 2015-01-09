# coding: utf-8
require 'socket'
require "thread"
require "pry"


require_relative "follower_maze/util/create_server"

Dir[File.dirname(__FILE__) + "/follower_maze/*.rb"].each { |file| require file }

module FollowerMaze

end
