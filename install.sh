if ! command -v conda &> /dev/null
then
    echo "Please install conda first!"
    exit
fi

if ! command -v git &> /dev/null
then
    echo "Please install git first!"
    exit
fi

sudo apt-get update && sudo apt-get install -y --no-install-recommends \ 
     build-essential cmake libzmqpp-dev libopencv-dev

conda create --name flightmare python=3.6
conda activate flightmare
echo "export FLIGHTMARE_PATH=${pwd}" >> ~/.bashrc
source ~/.bashrc

while true; do
    read -p "Do you have a GPU?" yn
    case $yn in
        [Yy]* ) pip install tensorflow-gpu==1.14; break;;
        [Nn]* ) pip install tensorflow==1.14; break;;
        * ) echo "Please answer yes or no.";;
    esac
done
pip install scikit-build
cd flightlib
pip install .

cd ../flightrl
pip install .
