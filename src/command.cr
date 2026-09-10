require "./storage"

def command_run(command : String) : String
  words = command.split
  storage = Store::INSTANCE

  case words[0]?
  when "SET"
    key = words[1]?
    value = words[2..].join(" ")

    if key.nil?
      return "ERR missing key"
    end

    if value.empty?
      return "ERR missing value"
    end

    storage.set(key, value)
    return "OK"

  when "GET"
    key = words[1]?

    if key.nil?
      return "ERR missing key"
    end

    value = storage.get(key)

    if value.nil?
      return "NOT FOUND"
    end

    return value

  when "DEL"
    key = words[1]?

    if key.nil?
      return "ERR missing key"
    end

    storage.delete(key)
    return "OK"

  else
    return "ERR unknown command"
  end
end