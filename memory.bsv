package memory;
import BRAM::*;
import DefaultValue::*;
import FIFO::*;
import FixedPoint::*;
import datatypes::*;

#define WIDTH 1080

interface Memory;
        method Action enq(DataType val, BramWidth c);
        method Action deq(BramWidth c);
        method ActionValue#(DataType) get;
endinterface

(*synthesize*)
module mkMemory(Memory);

	BRAM_Configure cfg = defaultValue;
	cfg.allowWriteResponseBypass = False;
	cfg.memorySize = WIDTH;
	BRAM2Port#(BramWidth, DataType) memory <- mkBRAM2Server(cfg);

	function BRAMRequest#(BramWidth, DataType) makeRequest(Bool write, BramWidth  addr, DataType data);
        return BRAMRequest {
                write : write,
                responseOnWrite : False,
                address : addr,
                datain : data
        };
	endfunction
	
	method Action enq(DataType data, BramWidth c);
			if( c < WIDTH)
			memory.portA.request.put(makeRequest(True, c, data));
	endmethod

	
	method Action deq(BramWidth c);
		if(c < WIDTH)
		memory.portB.request.put(makeRequest(False, c, 0));
	endmethod


        method ActionValue#(DataType) get;
		let d <- memory.portB.response.get;
		return d;
	endmethod

endmodule
endpackage
