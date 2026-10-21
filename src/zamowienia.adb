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
   begin
      loop
         select
            accept Get(o: order_type) do
               Ada.Text_IO.Put_Line("Wysłano zamówienie " & Integer'Image(o.number) & " na " & Integer'Image(o.amount) & " dżemów " & To_String(o.jam_type));
               magazyn.centrala.Give(o.number, o.amount, o.jam_type); 
            end Get;
         or
            accept Wait (o: order_type) do
               Ada.Text_IO.Put_Line("Obsługa entry Wait");
            end Wait;
         else
            delay 1.0;
         end select;
      end loop;
   end order;
      
end zamowienia;
