#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/lib/' + 'server_log_parser.rb'

abort 'ERROR: Missing argument' unless ARGV[0]
parser = ServerLogParser.new(ARGV[0])
result = parser.parse
abort parser.message  unless parser.success?

puts "URI\tView Count\tUnique View Count"
puts '=' * 55
result.each { |row| puts "#{row[:uri]}\t#{row[:count]}\t#{row[:unique_count]}"}
