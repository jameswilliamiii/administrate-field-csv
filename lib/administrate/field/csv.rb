require 'rails'
require 'administrate/engine'
require 'administrate/field/text'
# require 'administrate/field/text'
require 'csv'

module Administrate
  module Field
    class CSV < Administrate::Field::Text

      def transform
        return nil if data.blank?

        @transform ||= ::CSV.new(data, headers: has_headers?)
      end

      def rewind
        @transform.rewind
        @transform
      end

      def headers
        return [] unless has_headers? && transform

        transform.first&.headers || []
      end

      def has_headers?
        options[:headers] == true
      end

      def to_partial_path(partial = page)
        "/fields/csv/#{partial}"
      end

      def blank_sign
        options[:blank_sign] || '-'
      end

      class Engine < ::Rails::Engine
        Administrate::Engine.add_stylesheet 'administrate-field-csv/application'
        engine_root = root
        isolate_namespace Administrate
      end

    end
  end
end
