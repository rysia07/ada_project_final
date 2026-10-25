with Ada.Text_IO;
with Ada.Strings.Unbounded;
with ladowarka;
with magazyn;
with robot_manager;
with Ada.Numerics.Float_Random;

package body robot is
   function GetRobotIsReady(ID : Integer) return Boolean is
   begin
      return is_robot_ready(ID);
   end GetRobotIsReady;
   function SetRobotIsReady(ID: Integer; value: Boolean) return Boolean is
   begin
      is_robot_ready(ID) := value;
      return is_robot_ready(ID);
   end SetRobotIsReady;

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

   random_time : Duration;
   Gen: Ada.Numerics.Float_Random.Generator;
   begin
      Ada.Numerics.Float_Random.Reset(Gen);
      current_dostawa.id := -1;
      loop
         if is_ready(20) = False then
            ladowarka.ladowarka.ChargeRobot(can_charge, ID);
            if can_charge = False then
               recharging := False;
               Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " czeka na ładowanie");
            else
               recharging := True;
               Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " ładuje się");
               random_time := Duration(Ada.Numerics.Float_Random.Random(Gen)) * 12.0;
               delay random_time;
               battery := 100;
               recharging := False;
               ladowarka.ladowarka.EndCharging;
               Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " naładował się i jest gotowy do pracy");
               can_charge := False;
            end if;
         end if;

         if battery > 20 and success = False then
               random_time := Duration(Ada.Numerics.Float_Random.Random(Gen)) * 7.0;
               delay random_time;
               Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " podejmuje próbę dostarczenia dostawy");

               magazyn.centrala.Take(current_dostawa, success, jam_left);
               if success then
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " dostarczył towar do magazynu");
                  is_at_work := robot.SetRobotIsReady(ID, True);
                  current_dostawa.id := -1;
                  success := True;
               else
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " znowu nie mógł dostarczyć całego towaru");
                  --  current_dostawa.id := -1;
                  --  success := True;
                  --  is_at_work := robot.SetRobotIsReady(ID, True);
            end if;
         end if;

         if battery > 20 and success = True then
               accept TransferPackage(dostawa: Dostawy.Dostawa) do
                  current_dostawa := dostawa;
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " przyjął" & Integer'Image(current_dostawa.amount) & " sztuk towaru " & Ada.Strings.Unbounded.To_String(current_dostawa.jam_type));
               end TransferPackage;

               if current_dostawa.id /= -1 then 
                  Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " jedzie do magazynu");
                  random_time := Duration(Ada.Numerics.Float_Random.Random(Gen)) * 7.0;
                  delay random_time;

                  magazyn.centrala.Take(current_dostawa, success, jam_left);
                  battery := battery - 50;
                  if success then
                     is_at_work := robot.SetRobotIsReady(ID, True);
                     current_dostawa.id := -1;
                     Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " dostarczył towar do magazynu");
                     if battery > 0 then
                        Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " jest ponownie wolny");
                     end if;
                  else
                     Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " nie mógł dostarczyć całego towaru");
                     Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(ID) & " czeka na wolne miejsce w magazynie");
                  end if;  
               end if;          
         end if;
      end loop;
   end robot_type;
end robot;
