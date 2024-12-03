onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib ram32_2560_opt

do {wave.do}

view wave
view structure
view signals

do {ram32_2560.udo}

run -all

quit -force
