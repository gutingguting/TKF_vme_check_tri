onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ram_32_16384_opt

do {wave.do}

view wave
view structure
view signals

do {ram_32_16384.udo}

run -all

quit -force
