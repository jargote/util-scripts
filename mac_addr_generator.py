#!/usr/bin/python

import re
import random
import sys


def main():
    import pprint
    pprint.pprint(sys.argv)

    def random_hex():
       return pattern.match(hex(random.randint(0, 15))).groups()[0]
   
    pattern = re.compile(r'0x([0-9a-fA-F]{1})')

    addr_length = 6 

    addr = ['{0}{1}'.format(random_hex(), random_hex()) for i in range(0, addr_length)]

    return ':'.join(addr)


if __name__ == '__main__':
    sys.exit(main())
