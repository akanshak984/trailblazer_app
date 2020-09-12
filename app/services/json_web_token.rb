class JsonWebToken
  class << self
    def encode(payload)
      JWT.encode(payload, ENV['SECRET_KEY_BASE'])
    rescue StandardError
      nil
    end

    def decode(token)
      body = JWT.decode(token, ENV['SECRET_KEY_BASE'])[0]
      HashWithIndifferentAccess.new body
    rescue StandardError
      nil
    end
  end
end
