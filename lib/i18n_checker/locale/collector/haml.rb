require 'haml_parser'
require 'haml_parser/parser'
require 'i18n_checker/collectible'
require 'i18n_checker/locale/texts'

module I18nChecker
  module Locale
    module Collector
      class Haml
        include I18nChecker::Collectible

        attr_reader :file_caches

        def initialize(file_caches = I18nChecker::Cache::Files.new)
          @file_caches = file_caches
        end

        def collect(template_file)
          template = read_template_file(template_file)
          parser = HamlParser::Parser.new(filename: template_file)
          I18nChecker::Locale::Texts.new(collect_locale_texts(parser.call(template)))
        end

        private

        def read_template_file(template_file)
          file_caches.read(template_file).to_s
        end

        def collect_locale_texts(ast)
          locale_texts = []
          locale_texts << collect_locale_text(ast)
          return unless ast.respond_to?(:children)
          locale_texts << ast.children.map { |child| collect_locale_texts(child) }
          locale_texts.flatten.compact
        end

        def collect_locale_text(ast)
          return locale_text_from_script(ast) if ast.kind_of?(HamlParser::Ast::Script)
          return unless ast.respond_to?(:oneline_child)
          return unless ast.oneline_child.kind_of?(HamlParser::Ast::Script)
          locale_text_from_script(ast.oneline_child)
        end

        def locale_text_from_script(script_node)
          return unless translate_script = script_node.script.match(/^t\(\'+(.+)\'+\)$/)

          locale_text = translate_script[1]
          file_cache = file_caches.read(script_node.filename)
          column = file_cache[script_node.lineno].start_of(locale_text)

          I18nChecker::Locale::Text.new(
            file: script_node.filename,
            line: script_node.lineno,
            column: column,
            text: locale_text
          )
        end
      end
    end
  end
end