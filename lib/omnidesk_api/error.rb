# rubocop:disable Metrics/CyclomaticComplexity

module OmnideskApi
  class Error < StandardError
    class << self
      def from_response(response)
        status  = response[:status].to_i
        body    = response[:body].to_s

        klass = case status
                when 400      then OmnideskApi::BadRequest
                when 403      then error_for_403(body)
                when 404      then OmnideskApi::NotFound
                when 400..499 then OmnideskApi::ClientError
                when 502      then OmnideskApi::BadGateway
                when 500..599 then OmnideskApi::ServerError
                end

        klass.new(response) if klass
      end

      def error_for_403(body)
        if body =~ /rate limit exceeded/i
          OmnideskApi::TooManyRequests
        else
          OmnideskApi::Forbidden
        end
      end
    end

    def initialize(response = nil)
      @response = response
      super(build_error_message)
    end

    private

    def data
      @data ||=
        if (body = @response[:body]) && !body.empty?
          if body.is_a?(String) && @response[:response_headers] && @response[:response_headers][:content_type] =~ /json/
            JSON.decode(body)
          else
            { message: body }
          end
        end
    end

    def response_message
      case data
      when Hash
        data[:message]
      when String
        data
      end
    end

    def response_error
      "Error: #{data[:error]}" if data.is_a?(Hash) && data[:error]
    end

    def response_error_summary
      return nil unless data.is_a?(Hash) && !Array(data[:errors]).empty?

      summary = "\nError summary:\n"
      summary << data[:errors].map do |hash|
        hash.map { |k, v| "  #{k}: #{v}" }
      end.join("\n")

      summary
    end

    def build_error_message
      return nil if @response.nil?

      message =  "#{@response[:method].to_s.upcase} "
      message << "#{@response[:url]}: "
      message << "#{@response[:status]} - "
      message << response_message.to_s unless response_message.nil?
      message << response_error.to_s unless response_error.nil?
      message << response_error_summary.to_s unless response_error_summary.nil?
      message
    end
  end

  # Raised on errors in the 400-499 range
  class ClientError < Error; end

  # Raised when Omnidesk returns a 400 HTTP status code
  class BadRequest < ClientError; end

  # Raised when Omnidesk returns a 401 HTTP status code
  class Unauthorized < ClientError; end

  # Raised when Omnidesk returns a 403 HTTP status code
  class Forbidden < ClientError; end

  # Raised when Omnidesk returns a 403 HTTP status code
  # and body matches 'rate limit exceeded'
  class TooManyRequests < Forbidden; end

  # Raised when Omnidesk returns a 404 HTTP status code
  class NotFound < ClientError; end

  # Raised on errors in the 500-599 range
  class ServerError < Error; end

  # Raised when Omnidesk returns a 502 HTTP status code
  class BadGateway < ServerError; end
end
