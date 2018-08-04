GOPATH := $(PWD)
EXE := main

all: $(EXE)

%: %.go
	GOPATH=$(GOPATH) go build $^

clean:
	go clean

