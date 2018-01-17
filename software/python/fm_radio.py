# -*- coding: utf-8 -*-
"""
Created on Tue Mar 24 10:48:07 2015

@author: Administrator
"""

from __future__ import division
import Tkinter as tk
import multiprocessing
import numpy as np
from scipy import fftpack
from scipy import signal
#from rtlsdr import *
import usb
import pyaudio
from array import array

print('captured libusb devices:\n',usb.core.show_devices())
device = usb.core.find(idVendor=0x04b4)
print(device.manufacturer,'\n',device.product,'\n',device.backend,'\n')
print('list of the device config:\n',device.configurations())
print('will set this default config')
device.set_configuration()
print(device[0][0,0][0])
print(device[0][0,0][1])

RFRATE = 0.5e6

DOWN_FACTOR = 10

RFSIZE = int(512*10)
AUDIOSIZE = int(RFSIZE/DOWN_FACTOR)
FORMAT = pyaudio.paInt16
CHANNELS = 1
AUDIORATE = int(RFRATE/DOWN_FACTOR)

tempdata = np.zeros(AUDIOSIZE)

def read_data_thread(rf_q,ad_rdy_ev,audio_q):
    pre_data=0
    #filter design
    #FIR_LP = signal.firwin(19,17e3,1e3,window='hamming',True,False,RFRATE/2)
    #FIR_LP = signal.firwin(19,400e3/(RFRATE/2))
    #FIR_LP = signal.firwin(9,10e3/(AUDIORATE/2))
    FIR_LP = signal.firwin(2,1/(AUDIORATE/2))
    print(FIR_LP)
    #rfwindow = signal.hamming(RFSIZE)
    audiowindow = signal.hamming(AUDIOSIZE)
    fftwindow = signal.hamming(512)

    print("read data thread start")
    while 1:
        #ad_rdy_ev.wait(timeout=1000)
        while not rf_q.empty():
            #process data here
            data=rf_q.get()
            #data = np.frombuffer(data,dtype='h')
            #data=signal.decimate(data,4,ftype="fir")

            #data = signal.lfilter(FIR_LP,1.0,data)

            #demod method 1
            #angle_data=np.angle(data)
            #audioda=np.diff(angle_data)
            #audiodata=np.insert(audioda,0,angle_data[0]-pre_data)
            #pre_data=angle_data[-1]
            #audiodata=np.unwrap(audiodata,np.pi)


            #demod method 2
            #data_delay=np.insert(data,0,pre_data)
            #pre_data = data_delay[-1]
            #data_delay=np.delete(data_delay,-1)
            #diff_data=data*np.conj(data_delay)
            #audiodata=np.angle(diff_data)
            #audiodata=np.unwrap(audiodata)


            #demod method 3
            diff_data=np.diff(data)
            diff_data=np.insert(diff_data,0,data[0]-pre_data)
            pre_data=data[-1]
            audiodata=data.real*diff_data.imag-data.imag*diff_data.real
            audiodata=audiodata//(np.power(data.real,2)+np.power(data.imag,2))

            #demod method 4
            #data = data*10000
            #diff_data=np.diff(data)
            #diff_data=np.insert(diff_data,0,data[0]-pre_data)
            #pre_data=data[-1]
            #data_real = data.real.astype(np.dtype('i4'))
            #data_imag= data.imag.astype(np.dtype('i4'))
            #diff_data_real = diff_data.real.astype(np.dtype('i4'))
            #diff_data_imag= diff_data.imag.astype(np.dtype('i4'))
            #audiodata=data_real*diff_data_imag-data_imag*diff_data_real
            #audiodata=audiodata//(np.power(data_real,2)+np.power(data_imag,2))

            #audiodata=audiodata*1

            audiodata=signal.decimate(audiodata,DOWN_FACTOR,ftype="fir")
            #audiodata = audiodata[0::DOWN_FACTOR]

            #audiodata = signal.lfilter(FIR_LP,0.5,audiodata)
            #audiodata = signal.fftconvolve(FIR_LP, audiodata)

            audiodata_amp=audiodata*16384
            snd_data = audiodata_amp.astype(np.dtype('<i2')).tostring()
            audio_q.put(snd_data)
        #ad_rdy_ev.clear()


def rtlsdr_thread(rf_q,ad_rdy_ev,stop_q):

    #print('rtlsdr thread start')
    #sdr = RtlSdr()
    #sdr.rs = RFRATE
    #sdr.fc = RFFREQ
    #sdr.gain = RFGAIN
    ##sdr.freq_correction = -13
    #sdr.set_agc_mode(True)
    #print('  sample rate: %0.6f MHz' % (sdr.rs/1e6))
    #print('  center frequency %0.6f MHz' % (sdr.fc/1e6))
    #print('  gain: %d dB' % sdr.gain)
    #context=[ad_rdy_ev,rf_q]
    #sdr.read_samples_async(rtlsdr_callback, RFSIZE,context)
    #sdr.cancel_read_async()
    #sdr.close()
    #print('read rtlsdr thread ended')
    rdata = array('h')
    rdata.fromlist([0]*RFSIZE*2)
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
        rt_data = np.frombuffer(rdata,dtype='h')
        data = rt_data[::2] + 1j * rt_data[1::2]
        #rt_data_l = np.concatenate((rt_data_l,rt_data_s))
        #counter = counter + 1
        #if counter == 100:
            #rt_data = rt_data_l
            #rt_data_l = np.array([])
            #counter = 0
            ## 10M/s to 100k/s
            #rt_data_dec = rt_data[0::100]
        #rt_data_dec =signal.decimate(rt_data,4,ftype="fir")
            ##rf_p_s.send(rt_data)
            ##fft_p_s.send(fft_data)
        #rf_q.put(rdata)
        #rf_q.put(rt_data)
        #print(data.size)
        rf_q.put(data)
        
    print('exit thread')


#audio call back
zero_data = tempdata.astype(np.dtype('<i2')).tostring()
def audio_callback(in_data, frame_count, time_info, status):
    global audio_q
    global zero_data

    if not audio_q.empty():
        return (audio_q.get(),pyaudio.paContinue)
    else:
        #print('.')
        return (zero_data,pyaudio.paContinue)

#GUI
class Application(tk.Frame):
    def __init__(self,master=None):
        tk.Frame.__init__(self,master)
        self.grid()
        self.creatWidgets()

    def creatWidgets(self):
        self.quitButton=tk.Button(self,text='quit',command=root.destroy)
        self.quitButton.grid(column=1,row=3)

if __name__ == '__main__':
    #processes
    rf_q = multiprocessing.Queue()
    audio_q = multiprocessing.Queue()
    stop_q = multiprocessing.Queue()
    ad_rdy_ev=multiprocessing.Event()

    t_read_data=multiprocessing.Process(target=read_data_thread,args=(rf_q,ad_rdy_ev,audio_q,))
    t_rtlsdr=multiprocessing.Process(target=rtlsdr_thread,args=(rf_q,ad_rdy_ev,stop_q,))

    t_read_data.daemon=True
    t_read_data.start()
    t_rtlsdr.daemon=True
    t_rtlsdr.start()

    #pyaduio
    p = pyaudio.PyAudio()
    print("SoundCard Output @ %d Hz" % (AUDIORATE))
    print("SoundCard Frame Size @ %d" % (AUDIOSIZE))
    print("RF Input @ %d Hz" % (RFRATE))
    print("RF Frame Size @ %d" % (RFSIZE))
    stream = p.open(format=FORMAT,
            channels=CHANNELS,
            rate=AUDIORATE,
            input=False,
            output=True,
            frames_per_buffer=AUDIOSIZE,
            stream_callback=audio_callback)
    print('start stream')
    stream.start_stream()

    root=tk.Tk()
    app=Application(master=root)
    app.master.title("Test")
    app.mainloop()

    print('stream stoped')
    stream.stop_stream()
    stream.close()
