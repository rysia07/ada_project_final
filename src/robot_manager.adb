with Ada.Text_IO;
with ladowarka;
with robot;
with Dostawy;

package body robot_manager is
   task body robot_manager is
      robot1 : robot.robot_type(1);
      robot2 : robot.robot_type(2);
      robot3: robot.robot_type(3);
      robot4 : robot.robot_type(4);
      robot5 : robot.robot_type(5);
      temp_ready : Boolean := False;
      current_dostawa : Dostawy.Dostawa;
      charged_robot_id : Integer := -1;
   begin
      loop
         select
            accept TransferPackage(dostawa: Dostawy.Dostawa) do
               current_dostawa := dostawa;
            end TransferPackage;
            
            charged_robot_id := ladowarka.GetChargedRobotID;
            temp_ready := True;
            while temp_ready = True loop
               if robot.GetRobotIsReady(1) = True and charged_robot_id /= 1 then
                  robot1.TransferPackage(current_dostawa);
                  temp_ready := robot.SetRobotIsReady(1, False);
               elsif robot.GetRobotIsReady(2) = True and charged_robot_id /= 2 then
                  robot2.TransferPackage(current_dostawa);
                  temp_ready := robot.SetRobotIsReady(2, False);
               elsif robot.GetRobotIsReady(3) = True and charged_robot_id /= 3 then
                  robot3.TransferPackage(current_dostawa);
                  temp_ready := robot.SetRobotIsReady(3, False);
               elsif robot.GetRobotIsReady(4) = True and charged_robot_id /= 4 then
                  robot4.TransferPackage(current_dostawa);
                  temp_ready := robot.SetRobotIsReady(4, False);
               elsif robot.GetRobotIsReady(5) = True and charged_robot_id /= 5 then
                  robot5.TransferPackage(current_dostawa);
                  temp_ready := robot.SetRobotIsReady(5, False);
               end if;
            end loop;
         end select;
      end loop;
   end robot_manager;
end robot_manager;