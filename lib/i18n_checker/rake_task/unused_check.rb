require 'rake'
require 'rake/tasklib'
require 'i18n_checker/cache'
require 'i18n_checker/locale'
require 'i18n_checker/unused/detector'
require 'i18n_checker/unused/reporter/default'
require 'i18n_checker/command/unused_check'

module I18nChecker
  module RakeTask
    class UnusedCheck < ::Rake::TaskLib
      attr_accessor :name
      attr_accessor :reporter
      attr_accessor :source_paths
      attr_accessor :locale_file_paths
      attr_accessor :logger

      def initialize(name = :locale_unused_check)
        @name = name
        @source_paths = FileList['app/views/*', 'app/controllers/*', 'app/jobs/*', 'app/models/*', 'app/helpers/*']
        @locale_file_paths = FileList['config/locales/*']
        @logger = Logger.new(STDOUT)
        @logger.formatter = proc { |_severity, _datetime, _progname, message|
          "#{message}\n"
        }
        @reporter = I18nChecker::Unused::Reporter::Default.new(logger: logger)
        yield self if block_given?
        define
      end

      private

        def define
          desc 'Display unused translation text.'
          task(name) { run_task }
        end

        def run_task
          command = I18nChecker::Command::UnusedCheck.new(
            reporter: reporter,
            source_paths: source_paths,
            locale_file_paths: locale_file_paths,
          )
          command.run do |result|
            exit 1 unless result.empty?
          end
        end
    end
  end
end
