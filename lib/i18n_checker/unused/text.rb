require 'forwardable'

module I18nChecker
  module Unused
    class Text
      extend Forwardable

      def_delegators :locale_file, :lang

      def initialize(locale_file:, locale_text:)
        @locale_text = locale_text
        @locale_file = locale_file
      end

      private

        attr_reader :locale_file, :locale_text
    end
  end
end
