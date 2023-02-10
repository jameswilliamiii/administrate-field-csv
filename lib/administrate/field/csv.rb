require 'rails'
require 'administrate/engine'
require 'administrate/field/text'
require 'csv'

module Administrate
  module Field
    class CSV < Administrate::Field::Base

      def transform
        return nil if data.blank?

        @transform ||= ::CSV.new(data, **csv_args)
      end

      def rewind
        return nil if data.blank?

        transform.rewind
      end

      def headers
        return [] unless has_headers?

        rewind
        @headers ||= transform.first&.headers || []
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

      def truncate
        data.to_s.truncate(truncation_length)
      end

      private

      def truncation_length
        options.fetch(:truncate, 50)
      end

      def csv_args
        args = %i[col_sep row_sep quote_char headers return_headers]
        args.inject({}) { |res, arg| res.merge arg => options[arg] }.compact
      end

      class Engine < ::Rails::Engine
        Administrate::Engine.add_stylesheet 'administrate-field-csv/application'
        engine_root = root
        isolate_namespace Administrate
      end

    end
  end
end
