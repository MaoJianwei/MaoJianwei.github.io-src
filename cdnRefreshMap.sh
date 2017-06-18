
if [ $# != 1 ]
then
    echo 'usage: ./cdnRefreshMap.sh "http://www.maojianwei.com"'
    exit 1
fi

DOMAIN=$1
IDENTIFY="."

jekyll build

cd "./_site/"
FILE="../cdnRefreshMap.txt"


for i in $(find)
do
    LINK=${i:1}
    if [[ $LINK == *$IDENTIFY* ]]
    then
        echo ${DOMAIN}${LINK} >> ${FILE}
    else
        echo ${DOMAIN}${LINK}"/" >> ${FILE}
    fi
done
