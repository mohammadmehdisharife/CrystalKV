module Config
  def self.env(key : String, default : String) : String
    ENV[key]? || default
  end

  PORT = env("PORT", "9293").to_i
  HOST = env("HOST", "127.0.0.1")
end
