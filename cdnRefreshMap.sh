
if [ $# != 1 ]
then
    exit 1
fi

DOMAIN=$1

cd "./_site/"
for i in $(find)
do
    echo $DOMAIN${i:1}
done
