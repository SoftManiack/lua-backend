if [[ $1 == "" ]]
then
    echo "project path was not set"
    exit 0
fi

cd ~/web
[ -d .git ] && git pull || git clone $1 .
dep install
./app.lua staging --test
./app.lua staging --test coverage
exit 0
