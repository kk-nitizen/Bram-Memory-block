package Testbench;
import memory::*;
import datatypes::*;
import FixedPoint::*;
//#define USIZE 4;

(*synthesize*)
module mkTb(Empty);

	Memory memory_ifc[10];
	for(Integer i=0;i<10;i=i+1)
		memory_ifc[i]<-mkMemory;

	
        Reg#(int) cycle <-mkReg(0);
/*	
	for(Integer i=0;i<4;i=i+1)
	begin
	rule rname(cycle==fromInteger(i));
		DataType const_val1=12.2;
		//DataType const_val2=10.2;
		let temp = fxptMult(fromInteger(i),const_val1);
		//let temp2= fxptAdd(temp,const_val1);
		//DataType temp3;
		//temp3=fxptTruncate(temp);
		memory_ifc[i].enq(temp,fromInteger(i));
		cycle<=cycle+1;
	endrule
	end
*/

	for(Integer i=0;i<4;i=i+1)
	begin
	rule rname(cycle==fromInteger(i));
		$display("r%d",i);
		DataType const_val1=12.2;
		//DataType const_val2=10.2;
		//let temp = fxptMult(fromInteger(i),const_val1);
		//fxptWrite(2,temp); 
		//let temp2= fxptAdd(temp,const_val1);
		//DataType temp3;
		//temp3=fxptTruncate(temp);
		for(Integer l=0;l<10;l=l+1)
			memory_ifc[l].enq(fromInteger(i),fromInteger(i));
		cycle<=cycle+1;
	endrule
	end

	for(Integer j=4;j<11;j=j+2)
	begin
	rule rname(cycle==fromInteger(j));
		$display("r%d",j);
		$display("cycle=%0d",cycle);
		for(Integer l=0;l<10;l=l+1)
			memory_ifc[l].deq(fromInteger(j/2-2));
		cycle <= cycle+1;
	endrule
	end

	for(Integer k=5;k<12;k=k+2)
	begin
	rule rname(cycle==fromInteger(k));
		$display("k=%0d",k);
		for(Integer l=0;l<10;l=l+1)
		begin
			let temp1 <- memory_ifc[l].get;
			$write("memoryblock[");$write(l);$write("]");$write("=");fxptWrite(2,temp1);$write("at address");$write((k-1)/2-2);$write("\n");
		end
		cycle<=cycle+1;
	endrule
	end
      	
	rule final_end(cycle==12);
		$finish;
	endrule 

endmodule

endpackage

