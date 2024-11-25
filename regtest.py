#!/usr/bin/env python3

import os
import sys
import subprocess
import time
import threading
import glob
import time
import queue
import logging
import tabulate
from   tabulate import tabulate as tab

tabulate.PRESERVE_WHITESPACE = True

sys.path.append('site_scons')

from utils import *

msg_q = queue.Queue()
lg    = logging.getLogger('default')

#-------------------------------------------------------------------------------
#
#    Jobs for test
#
all_jobs = {
#    name            bv path, args
    '7a35t'       : ['7a35t', ''],
    '7a50t'       : ['7a50t', ''],
    'ac701'       : ['ac701', '']
}

jobs = { }

#-------------------------------------------------------------------------------
LOG_FILE = 'build/log/REGTEST'

#-------------------------------------------------------------------------------
def setup_logger(lvl):
    os.makedirs('build/log', exist_ok=True)
    levels = {
        'debug'    : logging.DEBUG,
        'info'     : logging.INFO,
        'warning'  : logging.WARNING,
        'error'    : logging.ERROR
    }
    logging.basicConfig(filename=LOG_FILE,
                        filemode='w',
                        level=levels[lvl],
                        format='%(asctime)s %(module)-12s %(levelname)-7s : %(message)s',
                        datefmt='%Y-%m-%d %H:%M:%S')

#-------------------------------------------------------------------------------
class Job(threading.Thread):
    def __init__(self, cmd, jbs):
        super().__init__()
        self.name = cmd[0]
        self.cmd  = cmd[1]
        self.jobs = jbs
        
    def run(self):
        p = subprocess.Popen(self.cmd, shell=True)
        #name = os.path.basename(p.args.split()[1])
        name = self.name
        msg = [name, None, 0]
        msg_q.put(msg)
        start = time.time()
        while True:
            rc = p.poll()
            if rc is None:  # still running
                time.sleep(0.1)
                continue
            elif rc == 0:   # success to finish
                elapsed = round(time.time() - start, 1)
                msg_q.put([name, 0, '{:.1f} s'.format(elapsed)])
                return
            else:           # failed
                elapsed = round(time.time() - start, 1)
                msg_q.put([name, rc, '{:.1f} s'.format(elapsed)])
                return

#-------------------------------------------------------------------------------
class OutMgr(threading.Thread):
    def __init__(self, jbs):
        super().__init__()
        self.jobs = {}
        for j in jbs:
            self.jobs[j] = [None, '']
            
        self.done_count = len(self.jobs)
        self.rc = 0

    def run(self):
        first = True
        light_color = True
        while True:
            try:
                msg = msg_q.get(timeout=0.5)
                lg.info('msg from ' + msg[0] + ': ' + str(msg[1]))
            except Exception as e:
                msg = None
                #lg.info(str(e))
                
            if msg:
                self.jobs[msg[0]] = (msg[1], msg[2])

                if msg[1] != None:
                    self.done_count -= 1

            if light_color:
                light_color = False
            else:
                light_color = True
                    
            out = []
            for name in self.jobs:
                if self.jobs[name][0] == None:
                    status = colorize('Running', 'magenta', light_color)
                    time_elapsed = ''
                elif self. jobs[name][0] == 0:
                    status = colorize('SUCCESS', 'green', True)
                    time_elapsed = colorize(self.jobs[name][1], 'white', True)
                else:
                    status = colorize('FAIL', 'red', True)
                    time_elapsed = colorize(self.jobs[name][1], 'white', True)
                    self.rc = -1

                out.append( (colorize(name, 'white', True), status, time_elapsed) )

            if first:
                first = False
            else:
                for _ in range(len(self.jobs) + 4):
                    sys.stdout.write("\x1b[1A\x1b[2K")

            print( tab( out, headers=[colorize(c, 'cyan', True) for c in ('Name', 'Status', 'Elapsed')],
                        tablefmt='rst', colalign=('left', 'center', 'right') ) )

            if not self.done_count:
                return

    def join(self, *args):
        threading.Thread.join(self, *args)
        return self.rc
        

#-------------------------------------------------------------------------------
def launch_parallel(jbs):
    os.makedirs('build/log', exist_ok=True)
    logs = glob.glob('build/log/*.log')
    for l in logs:
        os.remove(l)
    
    cmds = [(name, 'scons bv=' + jbs[name][0] + ' qs_run ' + jbs[name][1] +
            ' > build/log/' + name + '.log 2>&1') for name in jbs]
    
    jtlist = []
    for c in cmds:
        jthread = Job(c, jbs)
        jtlist.append( jthread )
        jthread.start()
        
    for jt in jtlist:
        jt.join()

#-------------------------------------------------------------------------------
def timeit(func):
    def runner(*args, **kwargs):
        start = time.time()
        res = func(*args, **kwargs)
        end = time.time()
        print_info( '\noverall time elapsed: {}\n'.format( round(end-start,1) ) )
        return res
    return runner

#-------------------------------------------------------------------------------
@timeit
def main():
    global jobs
    
    if len(sys.argv) > 1:
        for t in sys.argv[1:]:
            if t in all_jobs.keys():
                jobs[t] = all_jobs[t]
            else:
                print_error('E: unsupported test name {}'.format(t))
                sys.exit(-1)
    else:
        jobs = all_jobs

    setup_logger('info')
    omgr = OutMgr(jobs)
    omgr.start()
    launch_parallel(jobs)
        
    return omgr.join()

#-------------------------------------------------------------------------------
if __name__ == '__main__':
    sys.exit( main() )
    
#-------------------------------------------------------------------------------

