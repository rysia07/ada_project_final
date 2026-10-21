with Ada.Task_Termination;
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Containers.Indefinite_Doubly_Linked_Lists;

package body magazyn is
   function Check_state return Integer is
   begin
      Ada.Text_IO.Put_Line("Stan magazynu: " & Integer'Image(occupancy));
      Ada.Text_IO.Flush;
      return occupancy;
   end Check_state;
   
   task body centrala is
   begin 
      loop 
         select
            when occupancy < max_occupancy =>
               accept Take (id: Integer; amount: Integer; jam_type: ASU.Unbounded_String) do
                  if occupancy + amount <= max_occupancy then
                     id_list.Append(id);
                     amount_list.Append(amount);
                     type_list.Append(jam_type);
                     occupancy := occupancy + amount;
                     Ada.Text_IO.Put_Line("Przyjęto towar.");
                  else
                     Ada.Text_IO.Put_Line("Brak miejsca na całą dostawę!");
                  end if;
               end Take;
               
         else
            
            Ada.Text_IO.Put_Line("Magazyn pełny");
            delay 1.0;
         end select;
      end loop;
     end centrala;
           
end magazyn;
