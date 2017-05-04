all: build

build:
	hugo
	mv public docs

themes:
	mkdir -p themes/
	git clone https://github.com/digitalcraftsman/hugo-material-docs
	mv hugo-material-docs themes/

localdev:
	hugo server --buildDrafts

remotedev:
	hugo server --buildDrafts --bind 192.168.1.9 --baseURL http://192.168.1.9

clean:
	rm -rf public/
	rm -rf docs/
