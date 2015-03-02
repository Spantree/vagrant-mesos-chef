require 'socket'
require 'timeout'

def port_open?(ip, port, seconds=5)
  Timeout::timeout(seconds) do
    puts "Attempting to verify docker mirror at '#{ip}:#{port}'"
    begin
      TCPSocket.new(ip, port).close
      puts "Successfully connected to '#{ip}:#{port}'"
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
      puts "Connection refused or host unreachable at '#{ip}:#{port}'"
    end
  end
rescue Timeout::Error
  false
end

def get_docker_registry_mirror(possible_mirrors)
  possible_mirrors.each do |mirror_str|
    parts = mirror_str.split(":")
    host = parts[0]
    port = if parts[1] then parts[1].to_i else 5000 end
    if port_open?(host, port)
      return "#{host}:#{port}"
    end
  end
  return nil
end