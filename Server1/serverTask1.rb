require 'socket'

#define class ServerTask1

class ServerTask1
	def initialize(port,hostname)
		@port = 2000
		@hostname = "2620:9b::1929:ccba"
	end
	def task()
		loop {
			server = TCPServer.open(@port) #Informacja początowa
			client = server.accept
			client.puts(Time.now.ctime)
			client.puts "Dzień dobry!!! To ja Sprawdzacz <3"
			client.close
			server.close
			
			server = TCPSocket.open(@hostname, @port) #Odebranie kodu
			file = File.open("tmp.rb", "w")
			while line = server.gets
				file.puts(line)
			end
			file.close
			server.close
			server = TCPServer.open(@port) #Wysłanie odowiedzi
			client = server.accept
			if system("ruby tmp.rb -c")
				client.puts("Program jest poprawny.")
			else
				client.puts("Program jest niepoprawny sprawdź serwer.")
			end
			client.close
			server.close
			File.delete "tmp.rb"
		}
	end
end

serverTask1 = ServerTask1.new(1234,'localhost')
serverTask1.task