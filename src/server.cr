require "socket"
require "./config"
require "./hadnel"

class Server
  @server : TCPServer
  @host : String
  @port : Int32

  def initialize
    @host = Config::HOST
    @port = Config::PORT
    @server = TCPServer.new(@host, @port)
  end

  def run
    puts "server running on: #{@host}:#{@port}"

    loop do
      client = @server.accept?
      break if client.nil?
      spawn handle_client(client)
    end
  end

  def stop
    @server.close
  end
end