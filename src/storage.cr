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
end

module Store
  INSTANCE = Storage.new
end