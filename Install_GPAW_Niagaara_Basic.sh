conda deactivate
mkdir -p ./gpaw
export APPROOT=$PWD/gpaw
mkdir -p $APPROOT/opt
mkdir -p $APPROOT/modules
mkdir -p $APPROOT/build
MODULEPATH=$APPROOT/modules:$MODULEPATH
cd $APPROOT
git clone https://github.com/Yi-Cheng0101/NTHU_YI-CHENG.git
cp ./NTHU_YI-CHENG/Niagara/modulefile/* $APPROOT/modules
sed -i "s|\$APPROOT|$APPROOT|g" $APPROOT/modules/*

export CFLAGS="-fPIC"
export CXXFLAGS="-fPIC"
export FCFLAGS="-fPIC"


#install libxc
module load intel/2019u4
module load intelmpi/2019u4
module load openblas/0.3.7
module load python/3.8.5
cd $APPROOT/build
wget -O libxc-4.3.4.tar.gz http://www.tddft.org/programs/libxc/down.php?file=4.3.4/libxc-4.3.4.tar.gz
tar -xvf libxc-4.3.4.tar.gz
cd libxc-4.3.4
CC=mpicc CXX=mpicxx ./configure --prefix=$APPROOT/opt/libxc-4.3.4
make -j $(nproc) install 


#GPAW download
cd $APPROOT
wget https://pypi.org/packages/source/g/gpaw/gpaw-20.10.0.tar.gz
tar -xvf gpaw-20.10.0.tar.gz
wget https://wiki.fysik.dtu.dk/gpaw-files/gpaw-setups-0.9.20000.tar.gz
tar -xvf gpaw-setups-0.9.20000.tar.gz

#GPAW install
cd $APPROOT
module load libxc-4.3.4
pip3 uninstall -y gpaw
cp ./NTHU_YI-CHENG/Niagara/Install/siteconfig.py $APPROOT/gpaw-20.10.0/siteconfig.py
export GPAW_CONFIG=$APPROOT/gpaw-20.10.0/siteconfig.py
sed -i "s|\$APPROOT|$APPROOT|g" $APPROOT/gpaw-20.10.0/siteconfig.py
export GPAW_SETUP_PATH=$APPROOT/gpaw-setups-0.9.20000
export PATH=$PATH:$HOME/.local/bin
pip3 -v install gpaw --user


#GPAW input file
cd $APPROOT
git clone https://github.com/jussienko/gpaw-isc-2021.git
cp ./NTHU_YI-CHENG/Niagara/submit/submit.sh $APPROOT
