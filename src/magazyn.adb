with Ada.Task_Termination;
with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Containers.Indefinite_Doubly_Linked_Lists;
with stanowisko_wysyl;
with dostawy;

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
               accept Take (dostawa: Dostawy.Dostawa; success: out Boolean; jams_left: out Integer) do
                  if occupancy + dostawa.amount <= max_occupancy then
                     id_list.Append(dostawa.id);
                     
                     Is_Found := False;
                     Current_Idx := 1;
                     Target_Idx := 0;
                     
                     for C in type_list.Iterate loop
                        if type_list(C) = dostawa.jam_type then
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
                              amount_list.Replace_Element(Amt_C, amount_list(Amt_C) + dostawa.amount);
                              exit;
                           end if;
                           Current_Idx := Current_Idx + 1;
                        end loop;
                     else
                        amount_list.Append(dostawa.amount);
                        type_list.Append(dostawa.jam_type);
                     end if;
                           
                     occupancy := occupancy + dostawa.amount;
                     Ada.Text_IO.Put_Line("Przyjęto towar.");
                     jams_left := 0;
                     success := True;
                  else
                     Ada.Text_IO.Put_Line("Brak miejsca na całą dostawę!");
                     jams_left := max_occupancy - occupancy;
                     success := False;
                  end if;
               end Take;
               
         or
            when occupancy >= max_occupancy =>
               accept Full(dostawa: Dostawy.Dostawa; success: out Boolean; jams_left: out Integer) do
                  success := False;
                  jams_left := dostawa.amount;
                  Ada.Text_IO.Put_Line("Magazyn pełny");
               end Full;
               
         or 
            when occupancy /= 0 =>
               accept Give (dostawa: Dostawy.Dostawa; success: out Boolean; jams_left: out Integer) do
                     Is_Found := False;
                     Current_Idx := 1;
                     Target_Idx := 0;

                     for C in type_list.Iterate loop
                        if type_list(C) = dostawa.jam_type then
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
                              if amount_list(Amt_C) >= dostawa.amount then
                                   amount_list.Replace_Element(Amt_C, amount_list(Amt_C) - dostawa.amount);
                                    occupancy := occupancy - dostawa.amount;
                                    stanowisko_wysyl.StanowiskoWysyl.AcceptPrzesylka(dostawa);
                                   declare
                                      Unused : Integer := Check_state;
                                   begin
                                      null;
                                   end;
                                   exit;
                              else 
                              Ada.Text_IO.Put_Line("Nie ma wystarczającej ilości w magazynie");
                              jams_left := dostawa.amount - amount_list(Amt_C);
                              success := False;
                              end if;
                           end if;
                           Current_Idx := Current_Idx + 1;
                        end loop;
                     else 
                     Ada.Text_IO.Put_Line("Nie ma danego towaru w magazynie");
                     jams_left := dostawa.amount;
                     success := False;
                     end if;
               end Give;   
                    
         else
            delay 1.0;
         end select;
      end loop;
   end centrala;
           
end magazyn;
