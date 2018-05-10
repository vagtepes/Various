require 'socket'

def read(socket)
	while line=socket.gets
		puts "<"+line
		
		if line[3]==" "
			break
		end
	end
end

def write(socket, message)
	socket.puts message
	puts ">" + message
end

def main(host,port)
	time=Time.now
	puts "From: "
	from=gets.chomp
	puts "To: "
	to=gets.chomp
	socket= TCPSocket.new(host,port)
	
	read(socket)
	
	write(socket, "EHLO")
	
	read(socket)
	
	write(socket, "MAIL FROM:<#{from}>")
	
	read(socket)
	
	write(socket, "RCPT TO:<#{to}>")
	
	read(socket)
	
	write(socket, "DATA")
	
	read(socket)
	write(socket, "MIME-Version: 1.0")
	write(socket, "Received: by 10.0.9.1 with SMTP;")
	write(socket, "Date: #{time}")
  write(socket, "From: Evangelos <#{from}>")
	write(socket, "To: <#{to}")
	write(socket, "Message-ID: <randomstring@gmail.com")
	write(socket, "Subject: This is a test subject")
	write(socket, "Content-type: multipart/alternative; boundary=B_3608835800_24686825")
	write(socket, "--B_3608835800_24686825")
	write(socket, "Content-type: text/plain; \ncharset=utf-8")
	write(socket, "Content-transfer-encoding: 7bit")
	write(socket, "\nHello this is a test email please confirm that you can read it")
	write(socket, "\n--B_3608835800_24686825--")
	write(socket, "\r\n.\r\n")
	
	read(socket)
	
	socket.close
end

 main('eu-smtp-inbound-1.mimecast.com', 25)