rm MaoBlog.tar.gz

./cdnRefreshMap.sh "http://www.maojianwei.com"

cp ./cdnRefreshMapFile.txt ./_site/
cp ./cdnRefreshMapDir.txt ./_site/

rm ./_site/autoBuildIndex.sh
rm ./_site/CNAME
rm ./_site/cdnRefreshMap.sh
rm ./_site/migrateReadme.txt
rm ./_site/pushBlogSitemap.sh
echo "Mao: prepare _site OK"

tar -zcvf MaoBlog.tar.gz ./_site/
echo "Mao: release MaoBlog OK"
