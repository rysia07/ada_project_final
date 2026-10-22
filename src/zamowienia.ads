with Ada.Strings.Unbounded;


package zamowienia is
   package ASU renames Ada.Strings.Unbounded;
   use ASU;
   type order_type is record 
      number, amount: Integer;
      jam_type: ASU.Unbounded_String;
      success : Boolean := True;
      jam_left: Integer := 0;
   end record;
   
   
   procedure new_order (o:in out order_type; n, a: Integer; j_t:ASU.Unbounded_String); 
   task order is 
      entry Get(o: order_type);
   end order;
   

  
   

   

end zamowienia;
