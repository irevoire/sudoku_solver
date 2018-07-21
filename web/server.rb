require 'socket'
require 'json'

require_relative "../ruby/solver.rb"
require_relative "../ruby/utils.rb"

server = TCPServer.new 8888

while session = server.accept
	request = session.recv(1000)
	raw_grid = request[/\|(.+?)\|/m, 1]

	grid = parse(raw_grid)

	json = {}

	if (!solve(grid))
		json["state"] = "KO"
	else
		json["state"] = "OK"
	end

	json["grid"] = get_ascii_table(grid)

	# Now we generate an answer
	session.print "HTTP/1.1 200\r\n"
	session.print "Content-Type: text/html\r\n"
	session.print "Access-Control-Allow-Origin: null\r\n"
	session.print "\r\n"
	session.print json.to_json

	session.close
end
