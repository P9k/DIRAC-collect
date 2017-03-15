#! /bin/bash
#
# Collect energies from DIRAC calculations
#
# Usage:
#  ./collect.sh rab.dat

for i in `cat $1`; do printf "%0.2f\n" $i; done > distances.dat


echo "Dimer SCF:"
echo ""
for i in `cat $1`; do grep "@ SCF energy" $i/ccsd_t_fc_*_dimer_*_ar_br.out; done
for i in `cat $1`; do if grep -q "@ SCF energy" $i/ccsd_t_fc_*_dimer_*_ar_br.out; then grep "@ SCF energy" $i/ccsd_t_fc_*_dimer_*_ar_br.out | awk '{print $5}'; else echo "---------------------"; fi; done  > ar_br_scf.dat
for i in `cat $1`; do grep "@ SCF energy" $i/ccsd_t_fc_*_dimer_*_ar_br.out; done | wc -l

echo ""
echo "-------------"
echo ""

echo "Dimer CCSD(T):"
echo ""
for i in `cat $1`; do grep "@ Total CCSD(T) energy" $i/ccsd_t_fc_*_dimer_*_ar_br.out; done
for i in `cat $1`; do if grep -q "@ Total CCSD(T) energy" $i/ccsd_t_fc_*_dimer_*_ar_br.out; then grep "@ Total CCSD(T) energy" $i/ccsd_t_fc_*_dimer_*_ar_br.out | awk '{print $6}'; else echo "---------------------"; fi; done  > ar_br_ccsd.dat
for i in `cat $1`; do grep "@ Total CCSD(T) energy" $i/ccsd_t_fc_*_dimer_*_ar_br.out; done | wc -l


echo ""
echo "-------------"
echo ""

echo "Monomer SCF:"
echo ""
for i in `cat $1`; do grep "@ SCF energy" $i/ccsd_t_fc_*_monomer_*_ar_bg.out; done
for i in `cat $1`; do if grep -q "@ SCF energy" $i/ccsd_t_fc_*_monomer_*_ar_bg.out; then grep "@ SCF energy" $i/ccsd_t_fc_*_monomer_*_ar_bg.out | awk '{print $5}'; else echo "---------------------"; fi; done  > ar_bg_scf.dat
for i in `cat $1`; do grep "@ SCF energy" $i/ccsd_t_fc_*_monomer_*_ar_bg.out; done | wc -l

echo ""
echo "-------------"
echo ""

echo "Monomer CCSD(T):"
echo ""
for i in `cat $1`; do grep "@ Total CCSD(T) energy" $i/ccsd_t_fc_*_monomer_*_ar_bg.out; done
for i in `cat $1`; do if grep -q "@ Total CCSD(T) energy" $i/ccsd_t_fc_*_monomer_*_ar_bg.out; then grep "@ Total CCSD(T) energy" $i/ccsd_t_fc_*_monomer_*_ar_bg.out | awk '{print $6}'; else echo "---------------------"; fi; done  > ar_bg_ccsd.dat
for i in `cat $1`; do grep "@ Total CCSD(T) energy" $i/ccsd_t_fc_*_monomer_*_ar_bg.out; done | wc -l
#
#echo ""
#echo "-------------"
#echo ""

echo "Distance     Dimer, HF/a.u.       Dimer, CCSD(T)/a.u.       Monomer, HF/a.u.      Monomer, CCSD(T)/a.u." >> results.dat
paste distances.dat ar_br_scf.dat ar_br_ccsd.dat ar_bg_scf.dat ar_bg_ccsd.dat >> results.dat

