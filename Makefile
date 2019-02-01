driver_url := "ftp://ftp.infoprintsolutionscompany.com/frominfoprint/Printers/drivers/ip1400/mac/ibm_infoprint_1412.dmg"
driver_dmg_path := "IBM\ Infoprint\ 1412/IBM\ Infoprint\ 1412.mpkg/Contents/Resources/Packages/IBM\ Infoprint\ 1412.pkg/Contents/Resources/IBM\ Infoprint\ 1412.pax.gz"
driver_archive_path := "./Library/Printers/PPDs/Contents/Resources/en.lproj/IBM\ Infoprint\ 1412.gz"

.PHONY:
all: IBM-Infoprint-1412.ppd

.PHONY:
clean:
	rm -rf IBM\ Infoprint\ 1412 IBM\ Infoprint\ 1412.gz \
		   IBM\ Infoprint\ 1412.pax.gz ibm_infoprint_1412.dmg

IBM-Infoprint-1412.ppd: | IBM\ Infoprint\ 1412
	sed 's/.*\*cupsFilter:.*/\*cupsFilter:	\"application\/vnd.cups-postscript 100 foomatic-rip\"\
\*cupsFilter:	\"application\/vnd.cups-pdf 0 foomatic-rip\"/g' IBM\ Infoprint\ 1412 > IBM-Infoprint-1412.ppd

IBM\ Infoprint\ 1412: | IBM\ Infoprint\ 1412.gz
	gzip --decompress IBM\ Infoprint\ 1412.gz

IBM\ Infoprint\ 1412.gz: | IBM\ Infoprint\ 1412.pax.gz
	gzip --decompress --to-stdout IBM\ Infoprint\ 1412.pax.gz \
		| pax -r "${driver_archive_path}"
	mv "${driver_archive_path}" IBM\ Infoprint\ 1412.gz
	rm -rf ./Library

IBM\ Infoprint\ 1412.pax.gz: | ibm_infoprint_1412.dmg
	7z e ibm_infoprint_1412.dmg "${driver_dmg_path}"

ibm_infoprint_1412.dmg:
	wget "${driver_url}"
