#!/usr/bin/env ruby
require 'yaml'
require 'commander/import'
require 'robot_sweatshop/config'

program :name, 'Sweatshop Tears'
program :version, '0.0.1'
program :description, 'Package management for Robot Sweatshop'
program :help, 'Author', 'Justin Scott <jvscott@gmail.com>'

# command :job do |c|
#   c.syntax = 'sweatshop job <name>'
#   c.description = 'Creates and edits jobs.'
#   c.option '--auto', 'Create the file without opening the editor.'
#   c.action do |args, options|
#     options.default :auto => false
#     raise "Specify a job name as the command argument." if args.count < 1
#     job_file = CLI::Job.path_for args.first
#     CLI.create job_file, with_contents: CLI::Job.default
#     CLI.edit job_file unless options.auto
#   end
# end

# command :'job-list' do |c|
#   c.syntax = 'sweatshop job-list'
#   c.description = 'Lists available job configurations.'
#   c.action do |args, options|
#     CLI::Job.list
#   end
# end
