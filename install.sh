check_dependencies() {
    DEPS=0
    if [[ "$1" == "darwin"* ]]; then
        if ! which brew > /dev/null; then
            echo "================================================"
            echo "Pushroulette requires 'Homebrew' to be installed"
            echo 'Homebrew can be insatlled with ruby -e \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)\"'
            echo "================================================"
            ((DEPS++))
        fi
    elif [[ "$1" == "linux-gnu" }}; then
        if ! which apt-get > /dev/null; then
            echo "================================================"
            echo "Pushroulette requires 'apt-get' to be installed"
            echo "================================================"
        fi
    else
        echo "PUSH ROULETTE DOES NOT SUPPORT YOUR OPERATING SYSTEM"
        exit
    fi

    if ! which git > /dev/null; then
        echo "================================================"
        echo "Pushroulette requires 'git' to be installed"
        echo "Git can be installed with \"[sudo] brew install git\""
        echo "================================================"
        ((DEPS++))
    fi
    if ! which bundle > /dev/null; then
        echo "================================================"
        echo "Pushroulette requires 'bundler' to be installed"
        echo "Bundler can be installed with \"[sudo] gem install bundler\""
        echo "================================================"
        ((DEPS++))
    fi
    if [[ "$DEPS" != 0 ]]; then
        echo ""
        echo "You are missing the $DEPS dependency or depencencies above, please install them and rerun this command"
        echo ""
        exit
    fi
}


if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="MAC"

    check_dependencies("$OSTYPE")

    git clone https://github.com/Astonish-Results/pushroulette-sinatra.git ./

    if ! gem install bundler &> /dev/null; then
        echo "We need admin permissions to install the bundler ruby gem:"
        sudo gem install bundler
    fi
    bundle install
    brew install libav --with-libvorbis --with-sdl --with-theora


elif [[ "$OSTYPE" == "linux-gnu" ]]; then
    OS="LINUX"

    check_dependencies("$OSTYPE")

    echo "$OS"
    exit
else
    echo "PUSH ROULETTE DOES NOT SUPPORT YOUR OPERATING SYSTEM"
fi

echo "$OS"
