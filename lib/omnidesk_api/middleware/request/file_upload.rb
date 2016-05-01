require 'mime/types'

module OmnideskApi
  module Middleware
    module Request
      class FileUpload < Faraday::Middleware
        def call(env)
          env[:body] = create_files(env[:body]) if env[:body]
          @app.call(env)
        end

        private

        def create_files(params)
          return params unless params.is_a?(Hash)

          params.each_with_object({}) do |(k, v), hash|
            case v
            when Hash
              v = create_files(v)
            when Array
              v = k.to_sym == :attachments ? to_upload_io(v) : parse_array(v)
            end
            hash[k] = v
          end
        end

        def parse_array(array)
          array.map { |x| x.is_a?(Hash) ? create_files(x) : x }
        end

        def to_upload_io(paths)
          paths.map do |path|
            if path.is_a?(String)
              mime_type = MIME::Types.type_for(path).first
              mime_type ||= 'application/octet-stream'
              Faraday::UploadIO.new(path, mime_type)
            else
              path
            end
          end
        end
      end
    end
  end
end
