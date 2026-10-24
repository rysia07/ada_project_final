with Ada.Text_IO;
with Ada.Strings.Unbounded;
with robot;

package body ladowarka is
   is_charging: Boolean := False;
   function GetChargedRobotID return Integer is
   begin
      return charged_robot_id;
   end GetChargedRobotID;
   task body ladowarka is
   begin
      loop 
         select
            when is_charging = False =>
               accept ChargeRobot(is_free : out Boolean; robot_id : Integer) do
                  if is_charging then
                     is_free := False;
                  else
                     is_free := True;
                     charged_robot_id := robot_id;
                  end if;
                  is_charging := True;
               end ChargeRobot;
         or 
            when is_charging = True =>
               accept EndCharging;
               is_charging := False;
               charged_robot_id := -1;
         or
            when is_charging = False =>
               delay 3.0;
               Ada.Text_IO.Put_Line("Ładowarka nie ma robotów do ładowania");
         end select;
      end loop;
   end ladowarka;
end ladowarka;