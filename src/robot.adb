with Ada.Text_IO;
with Ada.Strings.Unbounded;
with ladowarka;
with magazyn;

package body robot is
   task body robot_type is

   battery: Integer := 100;
   recharging: Boolean := False;
   can_charge : Boolean := False;
   is_at_work : Boolean := False;
   function is_ready(required_energy : Integer)  return Boolean is
   begin
      return battery > required_energy and recharging = False;
   end is_ready;
   current_dostawa: Dostawy.Dostawa;

   success : Boolean := True;
   jam_left: Integer := 0;
   begin
      loop
         if is_ready(20) = False then
            ladowarka.ladowarka.ChargeRobot(can_charge);
            if can_charge = False then
               recharging := False;
               Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " czeka na ładowanie");
            else
               recharging := True;
               Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " ładuje się");
               delay 3.0;
               battery := 100;
               recharging := False;
               ladowarka.ladowarka.EndCharging;
               Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " naładował się i jest gotowy do pracy");
               can_charge := False;
            end if;
         end if;
         select
            when battery > 20 and jam_left = 0 =>
               accept TransferPackage(dostawa: Dostawy.Dostawa) do
                  current_dostawa := dostawa;
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " przyjął" & Integer'Image(current_dostawa.amount) & " sztuk towaru " & Ada.Strings.Unbounded.To_String(current_dostawa.jam_type));
               end TransferPackage;
               is_at_work := True;
               Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " jedzie do magazynu");
               delay 3.0;
               magazyn.centrala.Take(current_dostawa, success, jam_left);
               battery := battery - 100;
               if success then
                  is_at_work := False;
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " dostarczył towar do magazynu");
                  if battery > 0 then
                     Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " jest ponownie wolny");
                  end if;
               else
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " nie mógł dostarczyć całego towaru");
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " czeka na wolne miejsce w magazynie");
                  current_dostawa.amount := jam_left;
               end if;

            or
               when battery > 20 and jam_left > 0 =>
                  delay 3.0;
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " podejmuje próbę dostarczenia dostawy");
                  magazyn.centrala.Take(current_dostawa, success, jam_left);
                  if success then
                     Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " dostarczył towar do magazynu");
                     is_at_work := True;
                  else
                     Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " znowu nie mógł dostarczyć całego towaru");
                     current_dostawa.amount := jam_left;
                  end if;
         end select;
      end loop;
   end robot_type;
end robot;
