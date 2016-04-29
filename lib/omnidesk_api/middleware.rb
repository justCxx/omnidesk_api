require 'faraday'

require 'omnidesk_api/middleware/request/file_upload'
require 'omnidesk_api/middleware/response/raise_error'

module OmnideskApi
  module Middleware
    if Faraday::Middleware.respond_to? :register_middleware
      Faraday::Request.register_middleware(
        omnidesk_file_upload: -> { Request::FileUpload })

      Faraday::Response.register_middleware(
        omnidesk_raise_error: -> { Response::RaiseError })
    end
  end
end
