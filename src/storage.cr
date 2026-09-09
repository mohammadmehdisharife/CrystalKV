class Storage
    def initialize
        @store = Hash(String, String).new
    end

    def get(key : String)
        @store[key]?
    end

    def set(key : String, value : String)
        @store[key] = value
    end

    def delete(key : String)
        @store.delete(key)
    end
end