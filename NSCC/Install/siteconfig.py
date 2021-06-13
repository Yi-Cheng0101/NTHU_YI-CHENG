compiler = '$APPROOT/opt/mpich-3.3/bin/mpicc'
mpicompiler = '$APPROOT/opt/mpich-3.3/bin/mpicc'
mpilinker = '$APPROOT/opt/mpich-3.3/bin/mpicc'

xc = '/$APPROOT/opt/libxc-4.3.4/'
include_dirs += [xc + 'include']
extra_link_args += [xc + 'lib/libxc.a']
if 'xc' in libraries:
                libraries.remove('xc')



parallel_python_interpreter = False
extra_link_args += ['$AAPPROOT/lib/BLAS-3.8.0/libblas.a']
