with Ada.Strings.Unbounded;
with Dostawy;

package robot is
   task type robot_type(ID: Integer) is
      entry TransferPackage(dostawa: Dostawy.Dostawa);
   end robot_type;
end robot;
