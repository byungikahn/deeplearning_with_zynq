# Deep Learning with Zynq Boards
This project demonstrates that high-quality deep learning functions can be executed on AMD (formerly Xilinx) Zynq FPGA chips. Supported boards include Digilent's Zybo, Arty Z7, Pynq Z1, and TUL's Pynq Z2, which are widely used for development and training. This project is a part of commercial solution and is shared with permission from Neurocoms Co., Ltd.

# The design

The hardware design used here applies the so-called Neuron-machine architecture to fully utilize small hardware resources with almost no idle time, and is arguably the only solution capable of recognizing full video on the Zynq chip using deep learning.

# How to Run

1. Format a micro SD card of 8GB or larger to FAT32 and save BOOT.bin, class_label_ids2.txt, gpio.txt, and models_d.bin to the root directory. For the first three files, use the files in the arty_pynq folder for Arty Z7 or Pynq boards, and the files in the zybo folder for Zybq boards. Extract the models_d.bin file from the models_d folder into a single archive before use.
2. Insert the SD card into the card socket on the board.
3. Connect the laptop's HDMI output to the board's HDMI input and the monitor to the HDMI output.
4. Connect the power. You can use a USB or power adapter, but since the Zybo board consumes a lot of power, using an adapter is recommended over USB.
5. Press the push button on the board to change the model.
 
 - BTN0: General Object Detection
 - BTN1: General Object Classification
 - BTN2: ImageNet 1000-class Classification
 - BTN3: Age/Gender Classification from Face

# Source Codes

The source code directory contains major Verilog files. The full source code compilable in Vivado is provided as a bundle when you purchase an Arty Z7 board or Pynq board from Neurocoms Co., Ltd. If you need it, please contact the company (amy@neurocoms.com).

# Links

![Video Label](http://img.youtube.com/vi/2fA0fi3avMc/0.jpg)(https://www.youtube.com/watch?v=2fA0fi3avMc)
