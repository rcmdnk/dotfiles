#!/usr/bin/env python
try:
    import os
    import readline
    import atexit
    histfile = os.path.join(os.environ["HOME"], ".pyhist")
    open(histfile, 'a').close()
    readline.read_history_file(histfile)
    atexit.register(readline.write_history_file, histfile)
except IOError:
    pass
