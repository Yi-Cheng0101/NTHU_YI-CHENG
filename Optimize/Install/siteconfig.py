compiler = 'icc'
mpicompiler = 'mpicc'
mpilinker = 'mpicc'

# - static linking:
xc = '/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/opt/libxc-4.3.4/'
include_dirs += [xc + 'include']
extra_link_args += [xc + 'lib/libxc.a']
if 'xc' in libraries:
        libraries.remove('xc')


scalapack = True


hdf5 = True
if hdf5:
    path = '/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/opt/hdf5-1.8.21/'
    extra_link_args += ['-Wl,-rpath=%s/lib' % path]
    library_dirs += ['%s/lib' % path]
    include_dirs += ['%s/include' % path]
    libraries += ['hdf5']


libvdwxc = True
if libvdwxc:
    path = '/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/opt/scala/libvdwxc-0.4.0'
    extra_link_args += ['-Wl,-rpath=%s/lib' % path]
    library_dirs += ['%s/lib' % path]
    include_dirs += ['%s/include' % path]
    libraries += ['vdwxc']

elpa = True
if elpa:
        elpadir = '/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/opt/scala/elpa-2019.11.001'
        libraries += ['elpa']
        library_dirs += ['{}/lib'.format(elpadir)]
        extra_link_args += ['-Wl,-rpath={}/lib'.format(elpadir)]
        include_dirs += ['{}/include/elpa-2019.11.001'.format(elpadir)]


extra_link_args += ['-lfftw3_mpi']
extra_link_args += ['-lfftw3']
extra_link_args += ['-lifcore']
#include_dirs += ['/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/opt/scala/elpa-2019.11.001/include/elpa-2019.11.001/elpa']

extra_link_args += ['/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/opt/scala/libvdwxc-0.4.0/lib/libvdwxc.a']


fftw = True
#libraries += ['fftw3']
#extra_compile_args += ['-xCORE-AVX512']
extra_link_args += ['/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/opt/scala/elpa-2019.11.001/lib/libelpa.a']
#include_dirs += ['/scinet/niagara/software/2019b/opt/intel-2019u4-intelmpi-2019u4/fftw/3.3.8/include']
include_dirs += ['/scinet/intel/2019u4/compilers_and_libraries_2019.4.243/linux/mkl/include/fftw']
extra_compile_args += ['/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/yicheng/opt/scala/fftw3xf/libfftw3xf_intel.a']
extra_compile_args += ['-O3','-qopenmp']
extra_link_args += ['-qopenmp']



libraries += ['mkl_rt']
libraries = ['mkl_intel_thread','mkl_intel_lp64', 'mkl_sequential', 'mkl_core','mkl_lapack95_lp64', 'mkl_scalapack_lp64','mkl_blacs_intelmpi_ilp64']
#extra_link_args += ['-L/scratch/l/lcl_uotiscscc/lcl_uotiscsccs1040/didwdidw/IPM/lib -lipm']
#extra_link_args += ['-L/scinet/niagara/software/2019b/opt/intel-2019u4-intelmpi-2019u4/scalapack/2.0.2/lib']
parallel_python_interpreter = False

#extra_link_args += ['/scinet/niagara/software/2019b/opt/intel-2019u4/openblas/0.3.7/lib/libopenblas.a']
