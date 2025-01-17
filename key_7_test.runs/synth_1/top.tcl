# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_param simulator.modelsimInstallPath C:/modeltech_pe_10.4c/win32pe
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_property webtalk.parent_dir D:/vivado/key_7_test/key_7_test.cache/wt [current_project]
set_property parent.project_path D:/vivado/key_7_test/key_7_test.xpr [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language Verilog [current_project]
read_verilog -library xil_defaultlib {
  D:/vivado/key_7_test/key_7_test.srcs/sources_1/new/random.v
  D:/vivado/key_7_test/key_7_test.srcs/sources_1/new/timer.v
  D:/vivado/key_7_test/key_7_test.srcs/sources_1/new/display.v
  D:/vivado/key_7_test/key_7_test.srcs/sources_1/new/keyboard.v
  D:/vivado/key_7_test/key_7_test.srcs/sources_1/new/top.v
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc D:/vivado/key_7_test/key_7_test.srcs/constrs_1/new/test.xdc
set_property used_in_implementation false [get_files D:/vivado/key_7_test/key_7_test.srcs/constrs_1/new/test.xdc]


synth_design -top top -part xc7a100tcsg324-1


write_checkpoint -force -noxdef top.dcp

catch { report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb }
