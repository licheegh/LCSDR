# -*- coding: utf-8 -*-
"""
Created on Tue Mar 24 10:48:07 2015

@author: Administrator
"""

#import pyaudio
import usb
from array import array
import wave
import multiprocessing
#import queue
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import matplotlib.lines as line
import numpy as np
from scipy import fftpack
from scipy import signal
import time

print('captured libusb devices:\n',usb.core.show_devices())
device = usb.core.find(idVendor=0x04b4)
print(device.manufacturer,'\n',device.product,'\n',device.backend,'\n')
print('list of the device config:\n',device.configurations())
print('will set this default config')
device.set_configuration()
print(device[0][0,0][0])
print(device[0][0,0][1])

data =[]
Recording=False
FFT_LEN = 128
frames=[]
counter=1

CHUNK = 256*16/2

#Matplotlib
fig = plt.figure()
rt_ax = plt.subplot(212,xlim=(0,CHUNK), ylim=(-2**11-1000,2**11+1000))
#rt_ax = plt.subplot(212,xlim=(0,CHUNK), ylim=(-2**15-100,2**15+100))
fft_ax = plt.subplot(211)
fft_ax.set_yscale('log')
fft_ax.set_xlim(0,CHUNK)
fft_ax.set_ylim(1,1e6)
rt_ax.set_title("Real Time")
fft_ax.set_title("FFT Time")
rt_line = line.Line2D([],[])
fft_line = line.Line2D([],[])

rt_data=np.arange(0,CHUNK,1)
fft_data=np.arange(0,CHUNK,1)
rt_x_data=np.arange(0,CHUNK,1)
fft_x_data=np.arange(0,CHUNK,1)

def plot_init():
    rt_ax.add_line(rt_line)
    fft_ax.add_line(fft_line)
    return fft_line,rt_line,
    #return rt_line,
    
def plot_update(i):
    #global rt_data
    #global fft_data
    #rt_data = rf_q.get()
    #fft_data = fft_q.get()
    if rf_p_r.poll():
        rt_data = rf_p_r.recv()
        fft_data = fft_p_r.recv()
    
        rt_line.set_xdata(rt_x_data)
        rt_line.set_ydata(rt_data)
    
        fft_line.set_xdata(fft_x_data)
        fft_line.set_ydata(fft_data)
    return fft_line,rt_line,
    #return rt_line,


# pyaudio
#q = queue.Queue()

#processing block

window = signal.hamming(CHUNK)

def read_data_thread(rf_p_s,fft_p_s,stop_q):
    #global rt_data
    #global fft_data
    #global stop
    rdata = array('h')
    rdata.fromlist([0]*(CHUNK*2+1024))
    print('entering thread')

    counter = 0
    rt_data_l = np.array([])
    while stop_q.empty():
        try:
            device.read(0x86,rdata)
        except :
            print('timeout!')
            pass
        #print(rdata[0])
        #rt_data_s = np.frombuffer(rdata,dtype='h') - 2**11
        data = np.frombuffer(rdata,dtype='h',offset=2048)
        data = data[::2] + 1j * data[1::2]
        #print(data[0])
        #rt_data = rt_data[1024:]
        #rt_data_s = np.frombuffer(rdata,dtype='h')
        #rt_data_l = np.concatenate((rt_data_l,rt_data_s))
        #counter = counter + 1
        #if counter == 8:
            #rt_data_t = rt_data_l
            #rt_data_l = np.array([])
            #counter = 0
        rt_data = np.real(data)
        data_w = data * window 
        #fft_data = fftpack.rfft(rt_data_w,overwrite_x=True)
        fft_temp_data=fftpack.fftshift(fftpack.fft(data_w,overwrite_x=True))
        fft_data=np.abs(fft_temp_data)
        #rf_q.put(rt_data)
        #fft_q.put(fft_data)
            #rf_p_s.send(rt_data_t)
        rf_p_s.send(rt_data)
        fft_p_s.send(fft_data)
        
    print('exit thread')

#t=threading.Thread(target=read_audio_thead)
# windows need if __name__ == main for multiprocessing
rf_p_r,rf_p_s = multiprocessing.Pipe(duplex = False)
fft_p_r,fft_p_s = multiprocessing.Pipe(duplex = False)
stop_q = multiprocessing.Queue(maxsize = 1)
t=multiprocessing.Process(target=read_data_thread,args=(rf_p_s,fft_p_s,stop_q,))

t.daemon=True
t.start()

ani = animation.FuncAnimation(fig, plot_update,
                              init_func=plot_init, 
                              frames=1,
                              interval=5,
                              blit=True)
fig.show()

raw_input("wati for enter")
stop_q.put(1)
while rf_p_r.poll():
    rf_p_r.recv()
    fft_p_r.recv()
while t.is_alive():
    time.sleep(0.1)
    print ('.')
    rf_p_s.send(rt_data)
    fft_p_s.send(fft_data)
    pass
print("done")

