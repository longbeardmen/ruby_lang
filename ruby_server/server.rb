require 'socket'

server = TCPServer.new 2000
puts 'waiting for client'

def render(client, resp)
  client.puts("HTTP/1.0 200 OK\r\nContent-Type: text/html\r\n\r\n#{resp}")
end

loop do
  client = server.accept
  puts 'connected'

  data = client.gets
  type = data.split(' ').first
  path = data.split(' ')[1][1..-1]
  puts data

  if type != 'GET'
    resp = File.open('404.html').read
    render(client, resp)
  else
    if path == '404'
      resp = File.open('404.html').read
      render(client, resp)
    else
      resp = path.empty? ? File.open('index.html').read : File.open(path).read
      render(client, resp)
    end
  end

  client.close
  puts 'waiting for client'
end
