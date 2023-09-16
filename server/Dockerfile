FROM golang

#Make workdir
WORKDIR /usr/src/app

#Copy go mod and go sum
COPY go.mod go.sum ./

#This will download the files
RUN go mod download

#Copy root folder contents to the directory root
COPY . .

RUN go build -o app.exe


#Expose the port you wanna
EXPOSE 8080

#Run command
CMD ["./app.exe"]