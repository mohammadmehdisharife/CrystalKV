def command_run(command : String) : String
  words = command.split
  storage = Store::INSTANCE

  case words[0]?
  when "SET"
    key = words[1]?
    value = words[2..].join(" ")

    return "ERR missing key" if key.nil?
    return "ERR missing value" if value.empty?

    storage.set(key, value)
    return "OK"
    
  when "GET"
    key = words[1]?
    return "ERR missing key" if key.nil?

    value = storage.get(key)
    return value.nil? ? "NOT FOUND" : value

  when "DEL"
    key = words[1]?
    return "ERR missing key" if key.nil?

    storage.delete(key)
    return "OK"

  when "EXP"
    key = words[1]?
    ttl_str = words[2]?

    return "ERR missing key" if key.nil?
    return "ERR missing exp time" if ttl_str.nil?

    exp_time = ttl_str.not_nil!.to_i.seconds
    storage.exp(key.not_nil!, exp_time)
    return "OK"

  when "MSET"
    args = words[1..]
    return "ERR missing arguments" if args.empty?
    return "ERR wrong number of arguments for MSET" if args.size.odd?

    args.each_slice(2) do |pair|
      k = pair[0]
      v = pair[1]
      return "ERR missing value for key #{k}" if v.empty?
      storage.set(k, v)
    end
    return "OK"

  when "MGET"
    keys = words[1..]
    return "ERR missing key" if keys.empty?

    results = keys.map do |k|
      storage.get(k) || "(nil)"
    end
    return results.join("\n")

  when "MDEL"
    keys = words[1..]
    return "ERR missing key" if keys.empty?

    keys.each { |k| storage.delete(k) }
    return "OK"

  when "MEXP"
    args = words[1..]
    return "ERR missing arguments" if args.empty?
    return "ERR wrong number of arguments for MEXP" if args.size.odd?

    args.each_slice(2) do |pair|
      k = pair[0]
      ttl = pair[1].to_i.seconds
      storage.exp(k, ttl)
    end
    return "OK"
  else
    return "ERR unknown command"
  end
end
