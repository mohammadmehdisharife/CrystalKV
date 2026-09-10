class Storage
  def initialize
    @store = Hash(String, String).new
  end

  def get(key : String) : String?
    @store[key]?
  end

  def set(key : String, value : String) : Nil
    @store[key] = value
  end

  def delete(key : String) : Nil
    @store.delete(key)
  end
end

module Store
  INSTANCE = Storage.new
end