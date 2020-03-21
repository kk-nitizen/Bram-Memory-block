strtest:
	bsc  -sim  -u -g mkTb +RTS -K1000M -RTS -show-schedule -parallel-sim-link 8 -no-warn-action-shadowing -cpp Testbench.bsv
	bsc  -sim  -e mkTb -o hardware  *.ba 

strmain:
	bsc  -sim  -u -g mkMemory +RTS -K1000M -RTS -show-schedule -parallel-sim-link 8 -no-warn-action-shadowing -steps-warn-interval 8000000 -steps-max-intervals 8000000  -cpp memory.bsv
	bsc  -sim  -e mkLut -o hardware  *.ba
