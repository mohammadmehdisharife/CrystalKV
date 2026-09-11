struct Entry
  getter value : String
  getter expires_at : Time?
  
  def initialize(@value : String, @expires_at : Time? = nil)
  end
  
  def expired?(now : Time = Time.utc) : Bool
    e = @expires_at
    return false unless e
    e <= now
  end
end

class Storage
  def initialize
    @store = Hash(String, Entry).new
    self.start_clean_storage()
  end

  def get(key : String) : String?
    entry = @store[key]?
    return nil unless entry
  
    if entry.expired?
      @store.delete(key)
      return nil
    end
  
    entry.value
  end

  def set(key : String, value : String) : Nil
    @store[key] = Entry.new(value, nil)
  end

  def exp(key : String, ttl : Time::Span) : Bool
    entry = @store[key]?
    return false unless entry
    return false if entry.expired?
  
    @store[key] = Entry.new(entry.value, Time.utc + ttl)
    true
  end

  def delete(key : String) : Nil
    @store.delete(key)
  end

  private def clean_storage : Nil
    now = Time.utc
    @store.reject! do |key, entry|
      entry.expired?(now)
    end
  end

  def start_clean_storage : Nil
    spawn do
      loop do
        clean_storage
        Fiber.yield
        sleep 1.second
      end
    end
  end
end

module Store
  INSTANCE = Storage.new
end