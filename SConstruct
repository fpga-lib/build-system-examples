

import os
import sys

sys.dont_write_bytecode = True

import sys

sys.path.append( '.scons_ext' )

from helpers import *

#-------------------------------------------------------------------------------
#
#    Help info
#
help_info ="""
********************************************************************************     
    Available variants:
    ~~~~~~~~~~~~~~~~~~~
        ac701 (default)
        7a35t
        7a50t
     
    Usage:
    ~~~~~  
    scons [options] [variant|bv=<[path/]name>] [targets]
"""

Help(help_info)

#-------------------------------------------------------------------------------
#
#    General Settings
#

#-------------------------------------------------------------------------------
#
#    Variant management
#
if 'bv' in ARGUMENTS:
    variant = ARGUMENTS.get('bv')
else:
    variant = ARGUMENTS.get('variant', 'ac7001')

variant_name = variant.split(os.sep)[-1]

print_info('*'*80)
print_info(' '*27 + 'build variant: ' + variant_name)
print_info('*'*80 + '\n')

variant_path = os.path.join('src', 'cfg', variant, variant_name + '.scons')

if not os.path.exists(variant_path):
    print_error('\nError: unsupported variant: ' + variant)
    print(help_info)
    Exit(-3)

#-------------------------------------------------------------------------------
#
#    Environment
#
envx = Environment() #( tools = {} )

set_comstr(envx)

#SConscript(variant_path, exports='envx', variant_dir = '#build/' + variant_name, duplicate = 0)
SConscript(variant_path, exports='envx')

#-------------------------------------------------------------------------------

if 'dump' in ARGUMENTS:
    env_key = ARGUMENTS[ 'dump' ]
    if env_key == 'env':
        print( envx.Dump() )
    else:
        print( envx.Dump(key = env_key) )

#-------------------------------------------------------------------------------
