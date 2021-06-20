conda deactivate
mkdir -p ./gpaw
export APPROOT=$PWD/gpaw
mkdir -p $APPROOT/opt
mkdir -p $APPROOT/modules
mkdir -p $APPROOT/build
MODULEPATH=$APPROOT/modules:$MODULEPATH
cd $APPROOT
git clone https://github.com/Yi-Cheng0101/NTHU_YI-CHENG.git
cp ./NTHU_YI-CHENG/Optimize/modulefile/* $APPROOT/modules
sed -i "s|\$APPROOT|$APPROOT|g" $APPROOT/modules/*

export CFLAGS="-fPIC"
export CXXFLAGS="-fPIC"
export FCFLAGS="-fPIC"


#install libxc
module load intel/2019u4
module load intelmpi/2019u4
module load python/3.8.5
cd $APPROOT/build
wget -O libxc-4.3.4.tar.gz http://www.tddft.org/programs/libxc/down.php?file=4.3.4/libxc-4.3.4.tar.gz
tar -xvf libxc-4.3.4.tar.gz
cd libxc-4.3.4
CC=mpicc CXX=mpicxx ./configure --prefix=$APPROOT/opt/libxc-4.3.4
make -j $(nproc) install 

#install hdf5
module load libxc-4.3.4
cd $APPROOT/build
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.8/hdf5-1.8.21/src/hdf5-1.8.21.tar.bz2
tar -xvf hdf5-1.8.21.tar.bz2
cd hdf5-1.8.21
CC=mpicc CXX=mpicxx \
./configure --enable-parallel --enable-fortran \
--prefix=$APPROOT/opt/hdf5-1.8.21 \
--enable-shared --enable-hl
make -j $(nproc)
make install 

#install fftw-mkl
module load hdf5-1.8.21
cd $APPROOT/build
cp -r  /scinet/intel/2019u4/compilers_and_libraries_2019.4.243/linux/mkl/interfaces/fftw3xf      ./
chmod 777 fftw3xf
cd fftw3xf
chmod 777 makefile
make libintel64

#install libvdwxc
module load fftw-mkl
cd $APPROOT/build
wget https://launchpad.net/libvdwxc/stable/0.4.0/+download/libvdwxc-0.4.0.tar.gz
tar -xvf libvdwxc-0.4.0.tar.gz
cd libvdwxc-0.4.0
./configure \
--prefix=$APPROOT/opt/libvdxvc-0.4.0 \
--with-fftw3=/scinet/niagara/software/2019b/opt/intel-2019u4-intelmpi-2019u4/fftw/3.3.8
make -j
make install 


#install elpa
module load libvdxvc-0.4.0
cd $APPROOT/build
wget https://elpa.mpcdf.mpg.de/software/tarball-archive/Releases/2021.05.001/elpa-2021.05.001.tar.gz
tar -xvf elpa-2021.05.001.tar.gz
cd elpa-2021.05.001
./configure --prefix=$APPROOT/opt/elpa-2021.05.001 LDFLAGS="-lmkl_scalapack_lp64 -lmkl_blacs_intelmpi_lp64 -lmkl_core -lmkl_sequential -lmkl_intel_lp64"
make -j2
make install 
module load elpa-2021.05.001


#GPAW download
cd $APPROOT
wget https://pypi.org/packages/source/g/gpaw/gpaw-20.10.0.tar.gz
tar -xvf gpaw-20.10.0.tar.gz
wget https://wiki.fysik.dtu.dk/gpaw-files/gpaw-setups-0.9.20000.tar.gz
tar -xvf gpaw-setups-0.9.20000.tar.gz

#GPAW install
cd $APPROOT
pip3 uninstall -y gpaw
cp ./NTHU_YI-CHENG/Optimize/Install/siteconfig.py $APPROOT/gpaw-20.10.0/siteconfig.py
export GPAW_CONFIG=$APPROOT/gpaw-20.10.0/siteconfig.py
sed -i "s|\$APPROOT|$APPROOT|g" $APPROOT/gpaw-20.10.0/siteconfig.py
export GPAW_SETUP_PATH=$APPROOT/gpaw-setups-0.9.20000
export PATH=$PATH:$HOME/.local/bin
pip3 -v install gpaw --user


#GPAW input file
cd $APPROOT
git clone https://github.com/jussienko/gpaw-isc-2021.git
cp ./NTHU_YI-CHENG/Optimize/submit/submit.sh $APPROOT
rm $APPROOT/gpaw-isc-2021/input-files/copper.py
cp ./NTHU_YI-CHENG/Optimize/submit/copper.py $APPROOT/gpaw-isc-2021/input-files/copper.py
