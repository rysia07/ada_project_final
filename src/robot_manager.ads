with robot;
with Dostawy;

package robot_manager is
   task robot_manager is
      entry TransferPackage(dostawa: Dostawy.Dostawa);
   end robot_manager;
end robot_manager;