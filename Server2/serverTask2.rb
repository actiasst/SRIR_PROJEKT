require 'socket'

#define class ServerTask2

class ServerTask2
	def initialize(port,hostname)
		@port = port
		@hostname = hostname
	end
	def task()
	loop {
		server = TCPServer.open(@port) #Informacja początowa
		client = server.accept
		client.puts(Time.now.ctime)
		client.puts "Dzień dobry!!! To ja Wykonywacz <3"
		client.close
		server.close
		
		server = TCPSocket.open(@hostname, @port) #Odebranie kodu
		file = File.open("tmp.rb", "w")
		while line = server.gets
			file.puts(line)
		end
		file.close
		server.close
		start = Time.now
		system("ruby tmp.rb > output.txt")
		finish = Time.now - start
		server = TCPServer.open(@port) #Wysłanie odowiedzi
		client = server.accept
		file = File.new("output.txt","r")
		line = file.gets
			client.puts(line)
			client.puts(finish)
		file.close
		client.close
		server.close
		File.delete "tmp.rb"
		File.delete "output.txt"
	}
	end
end

serverTask2 = ServerTask2.new(1235,'localhost')
serverTask2.task