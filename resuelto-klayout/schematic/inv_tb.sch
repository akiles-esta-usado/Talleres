v {xschem version=3.4.4 file_version=1.2
}
G {}
K {}
V {}
S {}
E {}
N 210 -260 230 -260 {
lab=VIN}
N 300 -210 300 -190 {
lab=GND}
N 300 -320 300 -310 {
lab=VDD}
N 440 -250 440 -240 {
lab=VOUT}
N 430 -260 450 -260 {
lab=VOUT}
N 440 -260 440 -250 {
lab=VOUT}
C {devices/vdd.sym} 300 -320 0 0 {name=l1 lab=VDD}
C {devices/gnd.sym} 300 -190 0 0 {name=l2 lab=GND}
C {devices/vsource.sym} 40 -250 0 0 {name=Vdd value=1.8}
C {devices/vdd.sym} 40 -280 0 0 {name=l3 lab=VDD}
C {devices/gnd.sym} 40 -220 0 0 {name=l4 lab=GND}
C {devices/code_shown.sym} -650 -390 0 0 {name=NGSPICE
only_toplevel=false
format="tcleval( @value )"
value="
vin VIN 0 PULSE(0 1.8 1ns 0ns 0ns 2ns 4ns)

.param Wp = 4.5
.param Wn = Wp/3

.control
save all

tran 0.01n 8n
plot V(VIN) v(VOUT)

meas tran tpHL_in FIND time WHEN v(VIN)=0.9 TD=0 FALL=1
meas tran tpHL_fin FIND time WHEN v(VOUT)=0.9 TD=0 RISE=1

print tpHL_fin - tpHL_in

.endc
"}
C {devices/ipin.sym} 210 -260 0 0 {name=p3 lab=VIN}
C {devices/opin.sym} 450 -260 0 0 {name=p4 lab=VOUT}
C {devices/capa.sym} 440 -210 0 0 {name=C1
m=1
value=25f
footprint=1206
device="ceramic capacitor"}
C {devices/gnd.sym} 440 -180 0 0 {name=l5 lab=GND}
C {inv.sym} 300 -260 0 0 {name=X1}
C {devices/code.sym} 38.75 -541.875 0 0 {name=MODELS
only_toplevel=true
place=header
format="tcleval( @value )"
value="
.include $env(PDK_ROOT)/$env(PDK)/libs.tech/ngspice/design.ngspice

.lib $env(PDK_ROOT)/$env(PDK)/libs.tech/ngspice/sm141064.ngspice typical
.lib $env(PDK_ROOT)/$env(PDK)/libs.tech/ngspice/sm141064.ngspice mimcap_statistical
.lib $env(PDK_ROOT)/$env(PDK)/libs.tech/ngspice/sm141064.ngspice cap_mim
.lib $env(PDK_ROOT)/$env(PDK)/libs.tech/ngspice/sm141064.ngspice res_typical
.lib $env(PDK_ROOT)/$env(PDK)/libs.tech/ngspice/sm141064.ngspice bjt_typical
.lib $env(PDK_ROOT)/$env(PDK)/libs.tech/ngspice/sm141064.ngspice moscap_typical

"}
