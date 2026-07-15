require 'rails'
require 'administrate/engine'
require 'administrate/field/base'
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
        isolate_namespace Administrate

        # Sprockets only serves plugin assets it was told to precompile, so the
        # field's stylesheet must be added to the allowlist or it 404s under an
        # eager build. Propshaft serves everything on the asset path and keeps
        # `precompile` only as a no-op array, so appending there is harmless; we
        # still guard on Array so a host without an asset pipeline can't raise.
        initializer 'administrate-field-csv.assets.precompile' do |app|
          precompile = app.config.assets.precompile
          precompile << 'administrate-field-csv/application.css' if precompile.is_a?(Array)
        end
      end

    end
  end
end
