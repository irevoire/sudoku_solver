GOPATH := $(PWD)
EXE := main cell

all: $(EXE)

%: %.go
	GOPATH=$(GOPATH) go build $^

clean:
	go clean

