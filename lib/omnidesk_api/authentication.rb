module OmnideskApi
  module Authentication
    # Indicates if the client was supplied  Basic Auth
    # username and password
    #
    # @return [Boolean]
    def basic_authenticated?
      [@login, @password].all?
    end
  end
end
