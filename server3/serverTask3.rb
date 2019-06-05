require 'socket'

#define class ServerTask3

class ServerTask3
	def initialize(port,hostname)
		@port = port
		@hostname = hostname
	end
	def task()
		loop {
			server = TCPServer.open(@port) #Informacja początowa
			client = server.accept
			client.puts(Time.now.ctime)
			client.puts "Dzień dobry!!! To ja Przechowywacz <3"
			client.close
			server.close
			
			server = TCPSocket.open(@hostname, @port) #Odebranie rekordu
			line = server.gets
			server.close
			file = File.open("database.txt", "a")
			file.puts(line)
			file.close
			compute
		}
	end
	
	def compute()
		file = File.open("database.txt", "r")
		average = 0
		counter = 0
		min = -1
		max = 0
		while line = file.gets
			puts line
			tmp = line.split(";")
			if min == -1
				min = tmp[1].to_f
			end
			if tmp[1].to_f < min
				min = tmp[1].to_f
			end
			if tmp[1].to_f > max
				max = tmp[1].to_f
			end
			average += tmp[1].to_f
			counter += 1.0
			
		end	
		server = TCPServer.open(@port) #Informacja o wynikach
		client = server.accept
		client.puts(average/counter)
		client.puts(min)
		client.puts(max)
		client.close
		server.close
		
		puts (average/counter)
		puts (min)
		puts (max)
		file.close
	end
end

serverTask3 = ServerTask3.new(1236,'localhost')
serverTask3.task