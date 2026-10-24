with Ada.Strings.Unbounded;
with Dostawy;

package robot is
   subtype robot_bounds is Integer range 1..5;

   type robot_ready_array is array(robot_bounds) of Boolean;
   is_robot_ready : robot_ready_array := (True, True, True, True, True);
   function GetRobotIsReady(ID: Integer) return Boolean;
   function SetRobotIsReady(ID: Integer; value: Boolean) return Boolean;
   task type robot_type(ID: Integer) is
      entry TransferPackage(dostawa: Dostawy.Dostawa);
      entry can_transfer(ready: out Boolean);
   end robot_type;
end robot;
