require 'i18n_checker/version'
require 'i18n_checker/rake_task'
require 'i18n_checker/collectible'
require 'i18n_checker/cache'
require 'i18n_checker/locale'
require 'i18n_checker/locale/text_processor'
require 'i18n_checker/locale/collector/haml'
require 'i18n_checker/locale/collector/ruby'
require 'i18n_checker/locale/text'
require 'i18n_checker/locale/texts'
require 'i18n_checker/locale/key_path'
require 'i18n_checker/locale/file'
require 'i18n_checker/locale/files'
require 'i18n_checker/detector/locale_text_not_found'
require 'i18n_checker/detector/text_result'
require 'i18n_checker/detector/detected_result'
require 'i18n_checker/reporter/detect_result_reporter'
require 'i18n_checker/reporter/default_reporter'
require 'i18n_checker/locale_text_not_found_checker'

module I18nChecker
end
