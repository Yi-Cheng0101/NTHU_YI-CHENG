compiler = 'icc'
mpicompiler = 'mpicc'
mpilinker = 'mpicc'

# - static linking:
xc = '$APPROOT/opt/libxc-4.3.4/'
include_dirs += [xc + 'include']
extra_link_args += [xc + 'lib/libxc.a']
if 'xc' in libraries:
        libraries.remove('xc')


fftw = False
parallel_python_interpreter = False

extra_link_args += ['/scinet/niagara/software/2019b/opt/intel-2019u4/openblas/0.3.7/lib/libopenblas.a']
