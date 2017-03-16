# Nexys4 Pin Assignments
############################
# On-board Slide Switches  #
############################
set_property PACKAGE_PIN U9 [get_ports rst]
set_property IOSTANDARD LVCMOS33 [get_ports rst]
set_property PACKAGE_PIN U8 [get_ports asy_rst]
set_property IOSTANDARD LVCMOS33 [get_ports asy_rst]
set_property PACKAGE_PIN T16 [get_ports INT_1]
set_property IOSTANDARD LVCMOS33 [get_ports INT_1]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets INT_1]
set_property PACKAGE_PIN E16 [get_ports INT_2]
set_property IOSTANDARD LVCMOS33 [get_ports INT_2]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets INT_2]
set_property PACKAGE_PIN R10 [get_ports INT_3]
set_property IOSTANDARD LVCMOS33 [get_ports INT_3]
set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets INT_3]
set_property PACKAGE_PIN T8 [get_ports ck_j]
set_property IOSTANDARD LVCMOS33 [get_ports ck_j]
set_property PACKAGE_PIN R7 [get_ports sel]
set_property IOSTANDARD LVCMOS33 [get_ports sel]

#which led to choose
set_property PACKAGE_PIN M1 [get_ports which_led[7]]
set_property IOSTANDARD LVCMOS33 [get_ports which_led[7]]
set_property PACKAGE_PIN L1 [get_ports which_led[6]]
set_property IOSTANDARD LVCMOS33 [get_ports which_led[6]]
set_property PACKAGE_PIN N4 [get_ports which_led[5]]
set_property IOSTANDARD LVCMOS33 [get_ports which_led[5]]
set_property PACKAGE_PIN N2 [get_ports which_led[4]]
set_property IOSTANDARD LVCMOS33 [get_ports which_led[4]]
set_property PACKAGE_PIN N5 [get_ports which_led[3]]
set_property IOSTANDARD LVCMOS33 [get_ports which_led[3]]
set_property PACKAGE_PIN M3 [get_ports which_led[2]]
set_property IOSTANDARD LVCMOS33 [get_ports which_led[2]]
set_property PACKAGE_PIN M6 [get_ports which_led[1]]
set_property IOSTANDARD LVCMOS33 [get_ports which_led[1]]
set_property PACKAGE_PIN N6 [get_ports which_led[0]]
set_property IOSTANDARD LVCMOS33 [get_ports which_led[0]]


#show specific number
set_property PACKAGE_PIN L3 [get_ports led_display[6]]
set_property IOSTANDARD LVCMOS33 [get_ports led_display[6]]
set_property PACKAGE_PIN N1 [get_ports led_display[5]]
set_property IOSTANDARD LVCMOS33 [get_ports led_display[5]]
set_property PACKAGE_PIN L5 [get_ports led_display[4]]
set_property IOSTANDARD LVCMOS33 [get_ports led_display[4]]
set_property PACKAGE_PIN L4 [get_ports led_display[3]]
set_property IOSTANDARD LVCMOS33 [get_ports led_display[3]]
set_property PACKAGE_PIN K3 [get_ports led_display[2]]
set_property IOSTANDARD LVCMOS33 [get_ports led_display[2]]
set_property PACKAGE_PIN M2 [get_ports led_display[1]]
set_property IOSTANDARD LVCMOS33 [get_ports led_display[1]]
set_property PACKAGE_PIN L6 [get_ports led_display[0]]
set_property IOSTANDARD LVCMOS33 [get_ports led_display[0]]

set_property PACKAGE_PIN E3 [get_ports clk]
set_property IOSTANDARD LVCMOS33 [get_ports clk]

#set_property PACKAGE_PIN U8 [get_ports cp_in]
#set_property IOSTANDARD LVCMOS33 [get_ports cp_in]

############################
# On-board led             #
############################
#set_property PACKAGE_PIN T8 [get_ports signal]
#set_property IOSTANDARD LVCMOS33 [get_ports signal]
