onbreak {quit -force}
onerror {quit -force}

asim -t 1ps +access +r +m+ram_32_16384 -L xil_defaultlib -L xpm -L blk_mem_gen_v8_4_3 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ram_32_16384 xil_defaultlib.glbl

do {wave.do}

view wave
view structure

do {ram_32_16384.udo}

run -all

endsim

quit -force
