`define LIMIT 10

module atm_tb;

  // Inputs
  reg clk;
  reg reset;
  reg  card_inserted;
  reg  pin_valid;
  reg  withdraw;
  reg  deposit;
  reg  mini_statement;
  reg [3:0] enter_ammount;
  reg  face_recognition;
  

  //output
  wire show_balance;
  wire card_valid;
  wire account_locked;
  wire withdrawal_ok;
  wire deposit_ok;
  wire show_statement;
  wire pin_currect;
  wire face_varified;
  wire [1:0]pin_entry;

  // Instantiate the ATM module
  ATM ut(
    .clk(clk),
    .reset(reset),
    .card_inserted(card_inserted),
    .pin_valid(pin_valid),
    .withdraw(withdraw),
    .deposit(deposit),
    .mini_statement(mini_statement),
    .enter_ammount(enter_ammount),
    .face_recognition(face_recognition),
	 .card_valid(card_valid),
    .account_locked(account_locked),
    .withdrawal_ok(withdrawal_ok),
    .deposit_ok(deposit_ok),
	 .show_balance(show_balance),
    .show_statement(show_statement),
	 .pin_currect(pin_currect),
	 .face_varified(face_varified),
	 .pin_entry(pin_entry)
  );
  initial begin
  clk = 1'b0;
  card_inserted=0;
  withdraw=0;
  deposit=0;
  mini_statement=0;
  enter_ammount=0;
  face_recognition=0;
    
  end
  initial begin
   reset=1;
	clk = ~clk;#5clk = ~clk;
   #30
   reset=0;
	#30
//when enter ammount is less than LIMIT
   card_inserted=1;
	clk = ~clk;#5clk = ~clk;
   #30
	pin_valid=1;
	withdraw=1;
	clk = ~clk;#5clk = ~clk;
   #30
	enter_ammount=5;
	clk = ~clk;#5clk = ~clk;
	#30
	clk = ~clk;#5clk = ~clk;
   #30
	mini_statement=1;
	clk = ~clk;#5clk = ~clk;
   #30
   clk = ~clk;#5clk = ~clk;
	#30
   clk = ~clk;#5clk = ~clk;
	#30
	 
	 
//when enter ammount is more than LIMIT go to 	face recognation 
	 card_inserted=1;
	 clk = ~clk;#5clk = ~clk;
    #30
	 pin_valid=1;
	 withdraw=1;
	 clk = ~clk;#5clk = ~clk;
    #30
	 enter_ammount=12;
	 clk = ~clk;#5clk = ~clk;
	 #30
	 face_recognition=1;
	 clk = ~clk;#5clk = ~clk;
    #30
    mini_statement=1;
    clk = ~clk;#5clk = ~clk;
	 #30
	 clk = ~clk;#5clk = ~clk;
	 #30
    clk = ~clk;#5clk = ~clk;
	 #30
    clk = ~clk;#5clk = ~clk;
	 #30
	
	
// 3 times wrong pin entry account will be locked 24 hours  
	 card_inserted=1;
	 clk = ~clk;#5clk = ~clk;
    #30
	 
	pin_valid=0;
	 clk = ~clk;#5clk = ~clk;
	 #30
	 
	pin_valid=0;
	 clk = ~clk;#5clk = ~clk;
	 #30
	 
	pin_valid=0;
	 clk = ~clk;#5clk = ~clk;
	 #30
	 
	pin_valid=0;
	 clk = ~clk;#5clk = ~clk;
	 #30
	 
	pin_valid=1;
	 clk = ~clk;#5clk = ~clk;
	 #30
	 
// direct deposit	 
	 
	 card_inserted=1;
	 clk = ~clk;#5clk = ~clk;
    #30
	 pin_valid=1;
	 deposit=1;
	 clk = ~clk;#5clk = ~clk;
	 #30
	 clk = ~clk;#5clk = ~clk;
    #30
	 mini_statement=1;
	 clk = ~clk;#5clk = ~clk;
    #30
    clk = ~clk;#5clk = ~clk;
	 #30
    clk = ~clk;#5clk = ~clk;
	 #30
	 
//direct mini statement	 
	 
	 card_inserted=1;
	 clk = ~clk;#5clk = ~clk;
    #30
	 pin_valid=1;
	 mini_statement=1;
	 clk = ~clk;#5clk = ~clk;
	 #30
	 clk = ~clk;#5clk = ~clk;
    #30;
	
  end
  
endmodule