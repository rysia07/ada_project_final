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
      Is_Found    : Boolean;
      Current_Idx : Integer;
      Target_Idx  : Integer;
   begin 
      loop 
         select
            when occupancy < max_occupancy =>
               accept Take (id: Integer; amount: Integer; jam_type: ASU.Unbounded_String; success: out Boolean; jams_left: out Integer) do
                  if occupancy + amount <= max_occupancy then
                     id_list.Append(id);
                     
                     Is_Found := False;
                     Current_Idx := 1;
                     Target_Idx := 0;
                     
                     for C in type_list.Iterate loop
                        if type_list(C) = jam_type then
                           Is_Found := True;
                           Target_Idx := Current_Idx;
                           exit; 
                        end if;
                        Current_Idx := Current_Idx + 1;
                     end loop;
                     
                     if Is_Found then
                        Current_Idx := 1;
                        for Amt_C in amount_list.Iterate loop
                           if Current_Idx = Target_Idx then
                              amount_list.Replace_Element(Amt_C, amount_list(Amt_C) + amount);
                              exit;
                           end if;
                           Current_Idx := Current_Idx + 1;
                        end loop;
                     else
                        amount_list.Append(amount);
                        type_list.Append(jam_type);
                     end if;
                           
                     occupancy := occupancy + amount;
                     Ada.Text_IO.Put_Line("Przyjęto towar.");
                  else
                     Ada.Text_IO.Put_Line("Brak miejsca na całą dostawę!");
                     jams_left := max_occupancy - occupancy;
                     success := False;
                  end if;
               end Take;
               
         or
            when occupancy >= max_occupancy =>
               accept Full(amount : Integer; success: out Boolean; jams_left: out Integer) do
                  success := False;
                  jams_left := amount;
                  Ada.Text_IO.Put_Line("Magazyn pełny");
               end Full;
               
         or 
            when occupancy /= 0 =>
               accept Give (id: Integer; amount: Integer; jam_type: ASU.Unbounded_String; success: out Boolean; jams_left: out Integer) do
                     Is_Found := False;
                     Current_Idx := 1;
                     Target_Idx := 0;

                     for C in type_list.Iterate loop
                        if type_list(C) = jam_type then
                           Is_Found := True;
                           Target_Idx := Current_Idx;
                           exit; 
                        end if;
                        Current_Idx := Current_Idx + 1;
                     end loop;
                     
                     if Is_Found then
                        Current_Idx := 1;
                        for Amt_C in amount_list.Iterate loop
                           if Current_Idx = Target_Idx then
                              if amount_list(Amt_C) >= amount then
                                   amount_list.Replace_Element(Amt_C, amount_list(Amt_C) - amount);
                                   occupancy := occupancy - amount;
                                   Ada.Text_IO.Put_Line("Zamówienie" & Integer'Image(id) & " wykonane");
                                   declare
                                      Unused : Integer := Check_state;
                                   begin
                                      null;
                                   end;
                                   exit;
                              else 
                              Ada.Text_IO.Put_Line("Nie ma wystarczającej ilości w magazynie");
                              jams_left := amount - amount_list(Amt_C);
                              success := False;
                              end if;
                           end if;
                           Current_Idx := Current_Idx + 1;
                        end loop;
                     else 
                     Ada.Text_IO.Put_Line("Nie ma danego towaru w magazynie");
                     jams_left := amount;
                     success := False;
                     end if;
               end Give;   
                    
         else
            delay 1.0;
         end select;
      end loop;
   end centrala;
           
end magazyn;
