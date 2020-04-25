class Authorization
  def self.authorize(headers)
    if headers["Authorization"].present?
      decoded_token_data = JsonWebToken.decode(headers["Authorization"].split(" ").last)
      if decoded_token_data && User.find(decoded_token_data[:id])
        return decoded_token_data
      end
    end
    nil
  end
end
