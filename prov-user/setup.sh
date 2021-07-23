echo "### COPY USER FILES ###########################################"

set -x
rsync -av files/ ~
set +x

echo "### SETUP USER CODE ###########################################"

cd ~
if [[ ! -e nextcloud ]]
then
	set -x
	git clone https://github.com/nextcloud/server nextcloud
	cd nextcloud
	git submodule update --init
	set +x
else
	set -x
	cd nextcloud
	git pull
	git submodule update --remote --merge
	set +x
fi
cd -
