token = ENV['SECRET_TOKEN']
if !token
  unless token && token.length == 128
    token = SecureRandom.hex(64)
  end
end

SuchCoinWow::Application.config.secret_token = token
