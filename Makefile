spec: testbench.vcd
	python3 /rtlkon.py testbench.vcd
	java -cp /daikon.jar daikon.Daikon testbench.dtrace testbench.decls >spec.out

testbench.vcd: testbench_ez.vvp
	vvp -N $< +vcd >/dev/null

testbench_ez.vvp: testbench.sv nerv.sv
	iverilog -g2012  -o $@ -D STALL -D NERV_DBGREGS $^
	chmod -x $@

clean:
	rm -f *.vvp *.vcd *.dtrace *.decls
