record Entry, value : String

class Storage
  def initialize
    @store = Hash(String, Entry).new
  end

  def get(key : String) : String?
    @store[key]?.try(&.value)
  end

  def set(key : String, value : String) : Nil
    @store[key] = Entry.new(value)
  end

  def delete(key : String) : Nil
    @store.delete(key)
  end
end

module Store
  INSTANCE = Storage.new
end