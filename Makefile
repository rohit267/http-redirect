VERSION=`cat ./VERSION | awk NF`

all: clean update_version_file linux macos windows

clean:
	rm -f build/*

update_version_file:
	echo "package main\n\nconst AppVersion = \"${VERSION}\"" > version.go

linux: linux_amd64 linux_arm64 linux_arm

macos: macos_amd64 macos_arm64

windows: windows_amd64

linux_amd64:
	env GOOS=linux GOARCH=amd64 go build -ldflags="-w -s" -o build/http-redirect_linux_amd64_${VERSION}

linux_arm64:
	env GOOS=linux GOARCH=arm64 go build -ldflags="-w -s" -o build/http-redirect_linux_arm64_${VERSION}

linux_arm:
	env GOOS=linux GOARCH=arm go build -ldflags="-w -s" -o build/http-redirect_linux_arm_${VERSION}

macos_amd64:
	env GOOS=darwin GOARCH=amd64 go build -ldflags="-w -s" -o build/http-redirect_macos_amd64_${VERSION}

macos_arm64:
	env GOOS=darwin GOARCH=arm64 go build -ldflags="-w -s" -o build/http-redirect_macos_arm64_${VERSION}

windows_amd64:
	env GOOS=windows GOARCH=amd64 go build -ldflags="-w -s" -o build/http-redirect_windows_amd64_${VERSION}