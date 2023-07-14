`define LIMIT 10

module ATM (
  input clk,                       // Clock signal
  input reset,                     // Reset signal
  input card_inserted,             // Card insertion signal
  input pin_valid,                 // Valid PIN valid signal
  input withdraw,                  // Withdrawal signal
  input deposit,                   // Deposit signal
  input mini_statement,            // Mini statement signal
  input [3:0]enter_ammount,        //ammount entry signal
  input face_recognition,          //face_recognition signal
  output reg card_valid,           //card_valid signal
  output reg account_locked,       // Account locked signal
  output reg withdrawal_ok,        // Successful withdrawal signal 
  output reg deposit_ok,           // Successful deposit signal
  output reg show_balance,         // Display balance signal
  output reg show_statement,       // Display mini statement signal
  output reg pin_currect,          // pin_currect signal
  output reg face_varified,        //face_verified signal
  output reg [1:0] pin_entry=2'b00 //pin_entry signal
  
);

parameter [2:0]                    //states
  IDLE = 3'b000,
  PIN_ENTRY = 3'b001,
  DEPOSIT = 3'b010,
  WITHDRAWAL = 3'b011,
  FACE_RECOGNITION=3'b100,
  MINI_STATEMENT = 3'b101,
  BALANCE_DISPLAY = 3'b110,
  ACCOUNT_LOCKED = 3'b111;

reg [2:0] state;

always @(posedge clk)begin
  if(pin_valid==0)begin
	  pin_entry=pin_entry+1;
	  end
	  end
always @(pin_entry)begin
	if(pin_entry==2'b00)begin
	  account_locked<=1;
	  end
	 #24 ;
	 account_locked<=0;
	 end
	

always @(posedge clk or posedge reset )begin
  if (reset==1)
    state <= IDLE;
   
   else
   
    case ( state)
      IDLE:
        if (card_inserted==1) 
          state <= PIN_ENTRY;
		  else
		    state <=  IDLE;
        
      
      PIN_ENTRY:
        if (pin_valid==1) begin
          if(deposit)
			  state <=DEPOSIT;
			 else if(withdraw)
			  state <=WITHDRAWAL;
			  else if(mini_statement)
			   state <= MINI_STATEMENT;
				end
		  else if(pin_valid==0)begin
		    if(pin_entry==2'b00)
			  state <= ACCOUNT_LOCKED;
		    else
			  state <= PIN_ENTRY;
			 end
			
		DEPOSIT:
		if(deposit)
		  state <= BALANCE_DISPLAY;
		  
		WITHDRAWAL:
		
		if(enter_ammount<`LIMIT)
		 #70
		 state <= BALANCE_DISPLAY;
		
		
		else if(enter_ammount>`LIMIT)
		 #35
		 state <= FACE_RECOGNITION;
			

		
		BALANCE_DISPLAY:
		 if(mini_statement)
		   state <= MINI_STATEMENT;
		 else
		   state <= IDLE;
		 
		 
		 
		 MINI_STATEMENT:
			state <= IDLE;
			
		 FACE_RECOGNITION:
     
		if(face_recognition == 1)
		 #35
		 state <=BALANCE_DISPLAY;
		else
		 state <= IDLE;
		 
		 
      ACCOUNT_LOCKED:
        if (pin_valid==0)
		    state <=ACCOUNT_LOCKED;
        else
			 state <= IDLE;
			 
		default: state <= IDLE;
    endcase
end


always @(state or card_inserted or pin_valid or enter_ammount or face_recognition)
begin
case(state)
IDLE:begin
        if (card_inserted==1)
          card_valid<=1;
		  else
		    card_valid<=0;
        end
      
PIN_ENTRY:begin
        if (pin_valid==1)
          pin_currect<=1;
		  else
		    pin_currect<=0;
		  end
			 
DEPOSIT:begin
		  deposit_ok<=1;
		  end
		  
WITHDRAWAL:begin
		
		if(enter_ammount<`LIMIT)
		  #70
		  withdrawal_ok<=1;
		else if(enter_ammount>`LIMIT)
		  withdrawal_ok<=0;
		end
			
BALANCE_DISPLAY:begin
	show_balance<=1;
	$display("account balance");
   end
			
MINI_STATEMENT:begin
	show_statement<=1;
	end
		
		 
		 
		 
FACE_RECOGNITION:begin
	if(face_recognition == 1)begin
		 face_varified<=1;
		 withdrawal_ok<=1;
	end
	else begin
		face_varified<=0;
		withdrawal_ok<=0;
	end
end


ACCOUNT_LOCKED: ;
        

	
	
default:begin
	account_locked<=0;
	card_valid<=0;
	show_balance<=0;
	face_varified<=0;
	withdrawal_ok<=0;
	deposit_ok<=0;
	pin_currect<=0;
	show_statement<=0;
	end
  endcase
	
end 
	 
endmodule