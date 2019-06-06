require 'socket'

#define class MainClient

class MainClient
def initialize(port,hostname)
		@port = port
		@hostname = hostname
		@recordTmp = ""
	end
	def task1()
		server = TCPSocket.open(@hostname, @port) #Odebranie wiadomości początkowej
		
		line = server.gets
		puts line
		@recordTmp=line.split("\n")[0]
		line = server.gets
		puts line
		
		server.close
		server = TCPServer.open(@port) #Wysłanie kodu
		client = server.accept
		file = File.new("factorial.rb","r")
		while line = file.gets
			client.puts(line)
		end	
		file.close
		server.close
		client.close
		server = TCPSocket.open(@hostname, @port) #Odebranie wiadomości końcowej
		line = server.gets
			if line.chop == "Program jest poprawny."
				puts "Program jest poprawny."
				server.close
				task2
			else
				puts "Program jest niepoprawny  sprawdź serwer."
				server.close
				return
			end
		
	end
	
	def task2()
		server = TCPSocket.open(@hostname, @port+1) #Odebranie wiadomości początkowej
		
		line = server.gets
		puts line
		@recordTmp+= ";"
		@recordTmp+=line.split("\n")[0]
		line = server.gets
		puts line
		server.close
		
		server = TCPServer.open(@port+1) #Wysłanie kodu
		client = server.accept
		file = File.new("factorial.rb","r")
		while line = file.gets
			client.puts(line)
		end	
		file.close
		server.close
		client.close
		
		server = TCPSocket.open(@hostname, @port+1) #Odebranie wiadomości końcowej
		line = server.gets
		puts("Wynik to: " + line)
		
		file = File.open("database.txt", "a")
		tmp = line
		tmp=tmp.split("\n")
		line = server.gets
		line=line.split("\n")[0]
		@recordTmp = tmp[0] + ";" + line +";"+@recordTmp
		file.puts(@recordTmp)
		
		puts("Czas wykonania: " + line)
		server.close
		task3
	end
	
	def task3
		server = TCPSocket.open(@hostname, @port+2) #Odebranie wiadomości początkowej
		line = server.gets
		puts line
		@recordTmp+= ";"
		@recordTmp+=line.split("\n")[0]
		line = server.gets
		puts line
		server.close
	
		server = TCPServer.open(@port+2) #Wysłanie rekordu
		client = server.accept
		client.puts(@recordTmp)
		server.close
		client.close
		
		server = TCPSocket.open(@hostname, @port+2) #Odebranie wiadomości o wynikach
		line = server.gets
		puts ("Średni czas wykonania się programu: " + line)
		line = server.gets
		puts ("Minimalny czas wykonania się programu: " + line)
		line = server.gets
		puts ("Maksymalny czas wykonania się programu: " + line)
		server.close
	end
end

mainClient = MainClient.new(1234,'localhost')

mainClient.task1




