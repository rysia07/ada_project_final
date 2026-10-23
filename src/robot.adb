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
      current_dostawa: Dostawy.Dostawa;

      --dodaje ci zmienne żeby się skompilowało ~Marysia
      success : Boolean := True;
      jam_left: Integer := 0;

      battery: Integer := 100;
      recharging: Boolean := False;

   stupid_state : Integer;
   begin
      loop
         select
            when battery > 20 =>
               accept TransferPackage(dostawa: Dostawy.Dostawa) do
                  current_dostawa := dostawa;
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " przyjął" & Integer'Image(current_dostawa.amount) & " sztuk towaru " & Ada.Strings.Unbounded.To_String(current_dostawa.jam_type));
               end TransferPackage;
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " jedzie do magazynu");
                  delay 3.0;
                  --magazyn.centrala.Take(current_dostawa, success, jam_left);
                  battery := battery - 100;
                  current_dostawa := null;
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " dostarczył towar do magazynu");
                  stupid_state := magazyn.Check_state;
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " jest ponownie wolny");
                  if battery <= 0 then
                     recharging := True;
                     Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " ładuje się");
                     delay 3.0;
                     battery := 100;
                     recharging := False;
                     Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " jest gotowy do pracy");
                  end if;
         or
            delay 3.0;
            Ada.Text_IO.Put_Line("No gdzie ja mam kurwa tą pracę");
         end select;
      end loop;
   end robot_type;
end robot;
