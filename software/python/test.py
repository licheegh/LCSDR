#!/usr/bin/env python
#
# Copyright 2012 Jared Boone
#
# This file is part of HackRF.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; see the file COPYING.  If not, write to
# the Free Software Foundation, Inc., 51 Franklin Street,
# Boston, MA 02110-1301, USA.
#

#import os
#os.environ['PYUSB_DEBUG'] = 'debug'
#os.environ['PYUSB_LOG_FILENAME'] = 'D:\work\LCSDR\src\python\log.txt'

import usb
from array import array
import time
#import struct
#import sys
import multiprocessing


def read_data_thread(cnt,size):
    print('captured libusb devices:\n')
    print(usb.core.show_devices())
    device = usb.core.find(idVendor=0x04b4)
    print(device)
    print(device.backend)
    #print(device.manufacturer)
    #print(device.product)
    print('list of the device config:\n',device.configurations())
    print('will set this default config')
    device.set_configuration()
    print(device[0][0,0][0])
    print(device[0][0,0][1])
    data = array('B')
    data.fromlist(list(range(0,256)))
    data.fromlist(list(range(0,256)))
    #data.fromlist([0]*512)
    #data[510]=2
    #data[508]=2
    #data[506]=4
    #data.fromlist(list(range(255,-1,-1)))


    #wlen = device.write(0x2,array('h',[1,2]))
    #wlen = device.write(0x2,data)
    #print(wlen,'Bs send.')
    #print(data)
    time.sleep(0.1)
    rdata = array('H')
    rdata.fromlist([0]*size)
    #rdata = device.read(0x86,4)
    #rdata = device.read(0x86,512)

    while 1 :
        device.read(0x86,rdata)
        cnt.value = cnt.value + 1
        #print(len(rdata),'received')
        #print('%x' % (rdata[0] & 0x03))
        #print('%x' % rdata[0])
        print(rdata[0],rdata[1],rdata[2],rdata[3])
        #print(rdata)

if __name__ == '__main__':
    #device.read(0x86,rdata)
    #print(len(rdata),'received')
    #print(rdata)
    size = 2048
    cnt = multiprocessing.Value('i',0)
    t_read_data=multiprocessing.Process(target=read_data_thread,args=(cnt,size,))
    t_read_data.daemon=True
    t_read_data.start()

    count = 0
    while 1:
        time.sleep(1)
        print((cnt.value - count)*size/1000)
        count = cnt.value

