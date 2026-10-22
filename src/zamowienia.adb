with Ada.Strings.Unbounded;
with magazyn;
with Ada.Text_IO;

package body zamowienia is
   use ASU;
   
   procedure new_order (o: in out order_type; n, a: Integer; j_t: ASU.Unbounded_String) is
   begin
      o.number := n;
      o.amount := a;
      o.jam_type := j_t;
   end new_order;
   
   task body order is
      Current_Order : order_type;

      Leftovers: Integer;
     
      Is_Done: Boolean;
      S: Boolean;
   begin
      loop
         select
            accept Get(o: in order_type) do
               
               Current_Order := o;
            end Get;
            
            Ada.Text_IO.Put_Line("Przetwarzanie zamówienia " & Integer'Image(Current_Order.number) & " na " & Integer'Image(Current_Order.amount) & " dżemów.");
            
            Is_Done := False;
            S := True;
            
           
            while not Is_Done loop
               
               magazyn.centrala.Give(id       => Current_Order.number, 
                                     amount   => Current_Order.amount, 
                                     jam_type => Current_Order.jam_type, 
                                     success  => S, 
                                     jams_left => Leftovers);
               
              
               if S = True then
                  Is_Done := True;
               else
                 
                  delay 2.0;
               end if;
               
            end loop;
            
            Ada.Text_IO.Put_Line("Zamówienie " & Integer'Image(Current_Order.number) & " zrealizowane pomyślnie.");
         or
            delay 0.1;
         end select;
      end loop;
   end order;
      
end zamowienia;
