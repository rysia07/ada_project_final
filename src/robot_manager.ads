with robot;
with Dostawy;

package robot_manager is
   task robot_manager is
      entry TransferPackage(dostawa: Dostawy.Dostawa);
      --  entry EndTransfer(ID: Integer);
   end robot_manager;
end robot_manager;