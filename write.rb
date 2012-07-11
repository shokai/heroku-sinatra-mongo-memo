#!/usr/bin/env ruby
if ARGV.empty?
  STDERR.puts "ruby #{$0} hello!!"
  exit 1
end

require 'rubygems'
require 'bundler/setup'
require './init'

m = Memo.new(:body => ARGV.join(' '))
m.save!
