# -*- mode: ruby -*-

require 'bundler/setup'
require 'cookstyle'
require 'rubocop/rake_task'
require 'foodcritic'

RuboCop::RakeTask.new(:style) do |task|
  task.options << '--display-cop-names'
end

FoodCritic::Rake::LintTask.new(:lint) do |t|
  t.options = {
    fail_tags: ['any'],
  }
end

desc 'Runs knife cookbook test'
task :knife do
  sh 'bundle exec knife cookbook test zpool -o ../'
end

task default: [:style, :lint]
