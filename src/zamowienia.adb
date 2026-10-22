with Ada.Strings.Unbounded;
with magazyn;
with Ada.Text_IO;

package body zamowienia is
   use ASU;
   
   procedure new_order (o: in out order_type; n, a: Integer; j_t: ASU.Unbounded_String) is
   begin
      o.dostawa.id := n;
      o.dostawa.amount := a;
      o.dostawa.jam_type := j_t;
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
            
            Ada.Text_IO.Put_Line("Przetwarzanie zamówienia " & Integer'Image(Current_Order.dostawa.id) & " na " & Integer'Image(Current_Order.dostawa.amount) & " dżemów.");
            
            Is_Done := False;
            S := True;
            
           
            while not Is_Done loop
               
               magazyn.centrala.Give(Current_Order.dostawa,
                                     success  => S, 
                                     jams_left => Leftovers);
               
              
               if S = True then
                  Is_Done := True;
               else
                 
                  delay 2.0;
               end if;
               
            end loop;
            
            Ada.Text_IO.Put_Line("Zamówienie " & Integer'Image(Current_Order.dostawa.id) & " zrealizowane pomyślnie.");
         or
            delay 0.1;
         end select;
      end loop;
   end order;
      
end zamowienia;
