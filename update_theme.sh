echo -e "\033[0;32mUpdate themes...\033[0m"

cd themes/hugo-clarity
git remote add upstream https://github.com/chipzoller/hugo-clarity
git fetch upstream
git merge upstream/master
git push