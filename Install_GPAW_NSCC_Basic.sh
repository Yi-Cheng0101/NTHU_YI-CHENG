conda deactivate
mkdir -p ./gpaw
export APPROOT=$PWD/gpaw
mkdir -p $APPROOT/opt
mkdir -p $APPROOT/modules
mkdir -p $APPROOT/build
MODULEPATH=$APPROOT/modules:$MODULEPATH
cd $APPROOT
git clone https://github.com/Yi-Cheng0101/NTHU_YI-CHENG.git
cp ./NTHU_YI-CHENG/NSCC/modulefile/* $APPROOT/modules
sed -i "s|\$APPROOT|$APPROOT|g" $APPROOT/modules/*

export CFLAGS="-fPIC"
export CXXFLAGS="-fPIC"
export FCFLAGS="-fPIC"

#install mpich
cd $APPROOT/build
module load gcc/5.1.0
wget -q https://www.mpich.org/static/downloads/3.3/mpich-3.3.tar.gz
tar -xvf mpich-3.3.tar.gz
cd mpich-3.3
CC=gcc CXX=g++ FC=gfortran ./configure --prefix=$APPROOT/opt/mpich-3.3  --with-tm=/opt/bin/pbs
make -j $(nproc) install 


#install libxc
cd $APPROOT/build
module load mpich-3.3
wget -O libxc-4.3.4.tar.gz http://www.tddft.org/programs/libxc/down.php?file=4.3.4/libxc-4.3.4.tar.gz
tar -xvf libxc-4.3.4.tar.gz
cd libxc-4.3.4
CC=mpicc CXX=mpicxx ./configure --prefix=$APPROOT/opt/libxc-4.3.4
make -j $(nproc) install 


#install blas
module load libxc-4.3.4
cd $APPROOT/build
wget http://www.netlib.org/blas/blas.tgz
tar -xvf blas.tgz
cd BLAS-3.8.0
gfortran -O3 -std=legacy -m64 -fno-second-underscore -fPIC -c *.f
ar r libfblas.a *.o
ranlib libfblas.a
rm -rf *.o
ln -s libfblas.a libblas.a
mkdir -p $APPROOT/opt/BLAS-3.8.0/lib
cp libblas.a $APPROOT/opt/BLAS-3.8.0/lib

#GPAW download
cd $APPROOT
module load BLAS-3.8.0
wget https://pypi.org/packages/source/g/gpaw/gpaw-20.10.0.tar.gz
tar -xvf gpaw-20.10.0.tar.gz
wget https://wiki.fysik.dtu.dk/gpaw-files/gpaw-setups-0.9.20000.tar.gz
tar -xvf gpaw-setups-0.9.20000.tar.gz

#GPAW install
cd $APPROOT
module load python/3.8.3
pip3 uninstall -y gpaw
cp ./NTHU_YI-CHENG/NSCC/Install/siteconfig.py $APPROOT/gpaw-20.10.0/siteconfig.py
export GPAW_CONFIG=$APPROOT/gpaw-20.10.0/siteconfig.py
sed -i "s|\$APPROOT|$APPROOT|g" $APPROOT/gpaw-20.10.0/siteconfig.py
export GPAW_SETUP_PATH=$APPROOT/gpaw-setups-0.9.20000
export PATH=$PATH:$HOME/.local/bin
pip3 -v install gpaw --user
echo "GPAW install finish"

#GPAW input file
cd $APPROOT
git clone https://github.com/jussienko/gpaw-isc-2021.git
cp ./NTHU_YI-CHENG/NSCC/submit/submit.sh $APPROOT
