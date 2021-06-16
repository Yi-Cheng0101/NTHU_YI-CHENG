compiler = 'icc'
mpicompiler = 'mpicc'
mpilinker = 'mpicc'

xc = '$APPROOT/opt/libxc-4.3.4/'
include_dirs += [xc + 'include']
extra_link_args += [xc + 'lib/libxc.a']
if 'xc' in libraries:
        libraries.remove('xc')


scalapack = True


hdf5 = True
if hdf5:
    path = '$APPROOT/opt/hdf5-1.8.21/'
    extra_link_args += ['-Wl,-rpath=%s/lib' % path]
    library_dirs += ['%s/lib' % path]
    include_dirs += ['%s/include' % path]
    libraries += ['hdf5']


libvdwxc = True
if libvdwxc:
    path = '$APPROOT/opt/libvdwxc-0.4.0'
    extra_link_args += ['-Wl,-rpath=%s/lib' % path]
    library_dirs += ['%s/lib' % path]
    include_dirs += ['%s/include' % path]
    libraries += ['vdwxc']

elpa = True
if elpa:
        elpadir = '$APPROOT/opt/elpa-2019.11.001'
        libraries += ['elpa']
        library_dirs += ['{}/lib'.format(elpadir)]
        extra_link_args += ['-Wl,-rpath={}/lib'.format(elpadir)]
        include_dirs += ['{}/include/elpa-2019.11.001'.format(elpadir)]


extra_link_args += ['-lfftw3_mpi']
extra_link_args += ['-lfftw3']
extra_link_args += ['-lifcore']
extra_link_args += ['$APPROOT/opt/libvdwxc-0.4.0/lib/libvdwxc.a']


fftw = True
extra_link_args += ['$APPROOT/opt/elpa-2021.05.001/lib/libelpa.a']
include_dirs += ['/scinet/intel/2019u4/compilers_and_libraries_2019.4.243/linux/mkl/include/fftw']
extra_compile_args += ['$APPROOT/build/fftw3xf/libfftw3xf_intel.a']
extra_compile_args += ['-O3','-qopenmp']
extra_link_args += ['-qopenmp']




libraries += ['mkl_rt']
libraries = ['mkl_intel_thread','mkl_intel_lp64', 'mkl_sequential', 'mkl_core','mkl_lapack95_lp64', 'mkl_scalapack_lp64','mkl_blacs_intelmpi_ilp64']
parallel_python_interpreter = False

