require "socket"
require "./command"

def handle_client(client : TCPSocket)
    loop do
      command = client.gets
      break if command.nil?

      result = command_run(command)
      client.puts result
    end
end