require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'yard'
require 'i18n_checker/rake_task'

RSpec::Core::RakeTask.new(:spec)

I18nChecker::RakeTask::ReferenceCheck.new do |task|
  task.source_paths = FileList['spec/fixtures/haml/*', 'spec/fixtures/ruby/*']
  task.locale_file_paths = FileList['spec/fixtures/locales/**']
end

I18nChecker::RakeTask::UnusedCheck.new do |task|
  task.source_paths = FileList['examples/unused/**']
  task.locale_file_paths = FileList['examples/unused/locales/**']
end

I18nChecker::RakeTask::UnusedClean.new do |task|
  task.source_paths = FileList['examples/unused/**']
  task.locale_file_paths = FileList['examples/unused/locales/**']
end

YARD::Rake::YardocTask.new do |t|
  t.files = ['lib/**/*.rb']
end

task :default => :spec
