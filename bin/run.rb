#!/usr/bin/env ruby

require_relative '../lib/branded_food'
require_relative '../lib/common_food'
require_relative '../lib/cli'
require_relative '../lib/api'
require 'uri'
require 'json'
require 'pry'
require 'net/http'

CLI.new.run