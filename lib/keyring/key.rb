module Keyring
  class Key
    attr_reader :id, :signing_key, :encryption_key

    def initialize(id, key, key_size)
      @id = Integer(id)
      @key_size = key_size
      @encryption_key, @signing_key = parse_key(key)
    end

    def to_s
      "#<Keyring::Key id=#{id.inspect}>"
    end
    alias_method :inspect, :to_s

    private def parse_key(key)
      expected_key_size = @key_size * 2
      secret = decode_key(key, expected_key_size)

      raise InvalidSecret, "Secret must be #{expected_key_size} bytes, instead got #{secret.bytesize}" unless secret.bytesize == expected_key_size

      signing_key = secret[0...@key_size]
      encryption_key = secret[@key_size..-1]

      [encryption_key, signing_key]
    end

    private def decode_key(key, key_size)
      if key.bytesize == key_size
        key
      else
        begin
          Base64.strict_decode64(key)
        rescue ArgumentError
          Base64.decode64(key)
        end
      end
    end
  end
end
