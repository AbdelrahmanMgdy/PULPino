#!/bin/tcsh
source scripts/colors.sh

echo "${Green}--> Compiling standalone files... ${NC}"

rm -rf ${MSIM_LIBS_PATH}/standalone_lib

vlib ${MSIM_LIBS_PATH}/standalone_lib
vmap standalone_lib ${MSIM_LIBS_PATH}/standalone_lib

echo "${Green}Compiling component:   ${Brown} standalone ${NC}"
echo "${Red}"


vlog -quiet -sv -work standalone_lib +incdir+${RTL_PATH}/include ${RTL_PATH}/dp_ram.sv             || exit 1
vlog -quiet -sv -work standalone_lib +incdir+${RTL_PATH}/include ${RTL_PATH}/core_region.sv        || exit 1
vlog -quiet -sv -work standalone_lib +incdir+${RTL_PATH}/include ${RTL_PATH}/axi2mem.sv            || exit 1
vlog -quiet -sv -work standalone_lib +incdir+${RTL_PATH}/include ${RTL_PATH}/core2axi.sv           || exit 1
vlog -quiet -sv -work standalone_lib +incdir+${RTL_PATH}/include ${RTL_PATH}/axi_node_intf_wrap.sv || exit 1
vlog -quiet -sv -work standalone_lib +incdir+${RTL_PATH}/include ${RTL_PATH}/top.sv                || exit 1
vlog -quiet -sv -work standalone_lib +incdir+${RTL_PATH}/include ${RTL_PATH}/peripherals.sv        || exit 1
vlog -quiet -sv -work standalone_lib +incdir+${RTL_PATH}/include ${RTL_PATH}/axi2apb_wrap.sv       || exit 1
vlog -quiet -sv -work standalone_lib +incdir+${RTL_PATH}/include ${RTL_PATH}/timer_unit.sv         || exit 1

make -s -C ../tb/minsoc_vpi/                                                                       || exit 1

echo "${Cyan}--> standalone compilation complete! ${NC}"
