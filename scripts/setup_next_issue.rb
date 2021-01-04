#!/usr/bin/env ruby

require 'ostruct'
require 'optparse'
require 'fileutils'
require 'json'

class Scaffold
  def initialize(previous_issue, next_issue, verbose = false)
    @previous_issue_number = previous_issue
    @next_issue_number = next_issue
    @previous_issue_key = Scaffold.issue_key(previous_issue)
    @next_issue_key = Scaffold.issue_key(next_issue)
    @previous_issue_name = Scaffold.issue_name(previous_issue)
    @next_issue_name = Scaffold.issue_name(next_issue)
    @verbose = verbose
  end

  def self.issue_key(issue_number)
    "issue#{issue_number.to_i}"
  end

  def self.issue_name(issue_number)
    "Issue #{issue_number.to_i}"
  end

  def self.issue_exists(issue_number)
    File.exist?("./data/#{issue_key(issue_number)}.json")
  end

  def self.cwd
    Dir.pwd
  end

  def migrate
    make_directories
    copy_files
    update_files
  end

  def absolute_path(file)
    File.join(Scaffold.cwd, file)
  end

  def make_directories
    FileUtils.mkdir_p(File.join(Scaffold.cwd, "source/images/#{@next_issue_key}"), verbose: @verbose)
    FileUtils.mkdir_p(File.join(Scaffold.cwd, "source/#{@next_issue_key}"), verbose: @verbose)
  end

  def update_index_file
    index_html = absolute_path('source/index.html.erb')
    index_fp = File.open(index_html, 'r')
    contents = index_fp.read
    index_fp.close
    new_contents = contents.gsub(@previous_issue_key, @next_issue_key).gsub(
      Regexp.new(@previous_issue_name, 'i'), @next_issue_name
    )
    write_file(new_contents, index_html)
  end

  def update_files
    update_index_file
  end

  def copy_files
    data_json_starter = { "asset_dir": "#{@next_issue_key}/",
                          "pages": [
                            {
                              "partial_name": '',
                              "title": '',
                              "image": '',
                              "author": ''
                            }
                          ] }

    write_file(JSON.generate(data_json_starter), absolute_path("data/#{@next_issue_key}.json"),
               verbose: @verbose)
    FileUtils.cp(absolute_path('source/index.html.erb'), absolute_path("source/#{@previous_issue_key}.html.erb"),
                 verbose: @verbose)
    FileUtils.mkdir_p(File.join(Scaffold.cwd, "source/images/#{@next_issue_key}"), verbose: @verbose)
    FileUtils.mkdir_p(File.join(Scaffold.cwd, "source/#{@next_issue_key}"), verbose: @verbose)
  end

  def write_file(contents, filename, verbose: false)
    puts "Writing #{filename}" if verbose
    fp = File.open(filename, 'w')
    fp.write(contents)
    fp.close
  end
end

class Parser
  def self.parse(options)
    args = OpenStruct.new

    opt_parser = OptionParser.new do |opts|
      opts.banner = "Usage: #{$0} [options]"

      opts.on('-p', '--previous PREVIOUS_ISSUE_NUMBER', 'ex: 9') do |prev|
        args.previous = prev
      end

      opts.on('-n', '--next NEXT_ISSUE_NUMBER', 'ex: 10') do |nxt|
        args.next = nxt
      end

      opts.on('-v', '--verbose', 'be verbose') do
        args.verbose = true
      end

      opts.on('-h', '--help', 'Prints this help') do
        puts opts
        exit
      end
    end

    opt_parser.parse!(options)
    args
  end
end

begin
  options = Parser.parse ARGV
  if !options.previous || !options.next
    raise OptionParser::MissingArgument, 'You must include both previous and next issue names (-p and -n)'
  end
  if options.previous == options.next
    raise OptionParser::MissingArgument, 'You must have different previous and next issue names'
  end
  raise OptionParser::MissingArgument, 'The next issue appears to already exist.' if Scaffold.issue_exists(options.next)
  unless Scaffold.issue_exists(options.previous)
    raise OptionParser::MissingArgument, 'The previous issue does not appear to exist.'
  end
  unless File.exist?(File.join(Scaffold.cwd, 'source'))
    raise OptionParser::MissingArgument, 'This script must be run from the root directory'
  end
rescue Exception => e
  puts "*** Whoops: #{e}\n\n"
  puts Parser.parse %w[-h]
end

s = Scaffold.new(options.previous, options.next, options.verbose)
s.migrate
