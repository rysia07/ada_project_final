with Ada.Strings.Unbounded;
with robot; use robot;

package ladowarka is
   function GetChargedRobotID return Integer;
   task ladowarka is
      entry ChargeRobot(is_free: out Boolean; robot_id : Integer);
      entry EndCharging;
   end ladowarka;
   private 
      charged_robot_id : Integer := -1;

end ladowarka;
