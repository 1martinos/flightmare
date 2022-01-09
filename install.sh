# Make sure conda is installed
# (I used miniconda)
if ! command -v conda &> /dev/null
then
    echo "Please install conda first!"
    exit
fi

# Install required packages and set up the Bash enviroment for installs and later use
sudo apt-get update && sudo apt-get install -y --no-install-recommends \
     build-essential cmake libzmqpp-dev libopencv-dev
eval "$(conda shell.bash hook)"
CUR_DIR=$(dirname "$(readlink -f "$0")")
FLIGHTMARE_PATH=$CUR_DIR
echo "export FLIGHTMARE_PATH=$CUR_DIR" >> ~/.bashrc

# Set up conda enviroment
conda create --name flightmare python=3.6
conda activate flightmare
source ~/.bashrc

# Pick which tensorflow depending on whether user has a GPU
while true; do
    read -p "Do you have a GPU?" yn
    case $yn in
        [Yy]* ) pip install tensorflow-gpu==1.14; break;;
        [Nn]* ) pip install tensorflow==1.14; break;;
        * ) echo "Please answer yes or no.";;
    esac
done
pip install scikit-build

# Install packages
cd flightlib
pip install .

cd ../flightrl
pip install .

echo "Installed."
