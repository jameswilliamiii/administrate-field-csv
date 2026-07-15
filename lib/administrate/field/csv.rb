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

        # Administrate 1.0 bundles its own precompiled assets and no longer
        # precompiles plugin stylesheets on our behalf, so the field's CSS
        # must be registered explicitly or it 404s under an eager asset build.
        initializer 'administrate-field-csv.assets.precompile' do |app|
          app.config.assets.precompile += %w[administrate-field-csv/application.css]
        end
      end

    end
  end
end
