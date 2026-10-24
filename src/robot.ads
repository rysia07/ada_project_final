with Ada.Strings.Unbounded;
with Dostawy;

package robot is
   task type robot_type(ID: Integer) is
      entry TransferPackage(dostawa: Dostawy.Dostawa);
      entry can_transfer(ready: out Boolean);
   end robot_type;
end robot;
