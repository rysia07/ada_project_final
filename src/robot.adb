with Ada.Text_IO;
with Ada.Strings.Unbounded;
with magazyn;

package body robot is
   task body robot_type is

-- wait for new package / idle
-- receive package
-- wait for some time to move the package
-- wait for new package / idle

   current_id : Integer;
   current_amount : Integer;
      current_jam_type: Ada.Strings.Unbounded.Unbounded_String;

      --dodaje ci zmienne żeby się skompilowało ~Marysia
      success : Boolean := True;
      jam_left: Integer := 0;

   stupid_state : Integer;
   begin
      loop
         select
            accept TransferPackage(id: Integer; amount: Integer; jam_type: Ada.Strings.Unbounded.Unbounded_String) do
               current_id := id;
               current_amount := amount;
               current_jam_type := jam_type;
               Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " przyjął" & Integer'Image(amount) & " sztuk towaru " & Ada.Strings.Unbounded.To_String(jam_type));
            end TransferPackage;
            Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " jedzie do magazynu");
            delay 3.0;
            --magazyn.centrala.Take(current_id, current_amount, current_jam_type, success, jam_left);
            Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " dostarczył towar do magazynu");
            stupid_state := magazyn.Check_state;
            Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " jest ponownie wolny");
         or
            delay 3.0;
            Ada.Text_IO.Put_Line("No gdzie ja mam kurwa tą pracę");
         end select;
      end loop;
   end robot_type;
end robot;
