with Ada.Text_IO;
with ladowarka;
with robot;
with Dostawy;

package body robot_manager is
   task body robot_manager is
      --  subtype robot_bounds is Integer range 1..5;
      robot1 : robot.robot_type(1);
      robot2 : robot.robot_type(2);
      robot3: robot.robot_type(3);
      robot4 : robot.robot_type(4);
      robot5 : robot.robot_type(5);
      --  type robot_ready_array is array(robot_bounds) of Boolean;
      --  is_robot_ready : robot_ready_array := (True, True, True, True, True);
      robot_index : Integer := 0;
      temp_ready : Boolean := False;
      current_dostawa : Dostawy.Dostawa;
      charged_robot_id : Integer := -1;
      quit_loop : Boolean := False;
      --  type robot_array is array(robot_bounds) of robot.robot_type;
      --  robots : robot_array := (robot1, robot2, robot3, robot4, robot5);
      --  temp_robot: robot.robot_type;
   begin
      loop
         select
            accept TransferPackage(dostawa: Dostawy.Dostawa) do
               current_dostawa := dostawa;
               Ada.Text_IO.Put_Line("Accepting a package");
            end TransferPackage;
            quit_loop := False;
            --  while temp_ready = False or quit_loop = True loop
            --        Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(robot_index) & " is currently in the loop");
            --        charged_robot_id := ladowarka.GetChargedRobotID;
            --        if robot_index = 0 and charged_robot_id /= 1 then
            --           robot1.can_transfer(temp_ready);
            --        elsif robot_index = 1 and charged_robot_id /= 2 then
            --           robot2.can_transfer(temp_ready);
            --        elsif robot_index = 2 and charged_robot_id /= 3 then
            --           robot3.can_transfer(temp_ready);
            --        elsif robot_index = 3 and charged_robot_id /= 4 then
            --           robot4.can_transfer(temp_ready);
            --        elsif robot_index = 4 and charged_robot_id /= 5 then
            --           robot5.can_transfer(temp_ready);
            --        end if;
            --        robot_index := robot_index + 1;
            --        if robot_index = 5 then
            --           robot_index := 0;
            --           quit_loop := True;
            --        end if;
            --        Ada.Text_IO.Put_Line("Robot nr" & Integer'Image(robot_index) & " is after the loop");
            --  end loop;
            --  if temp_ready then
                              charged_robot_id := ladowarka.GetChargedRobotID;

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
            --  end if;
            --  temp_ready := False;
            --  robot_index := 0;
            --   do
               --  for i in robot_bounds loop
               --     temp_robot := robots(i);
               --     if temp_robot.is_ready(20) and not temp_robot.is_at_work then
               --        free_robot := temp_robot;
               --     end if;
               --  end loop;
            --  end get_free_robot;
            --  or
            --     accept EndTransfer(ID : Integer) do
            --        for I in robot_bounds loop 
            --           if I = ID then
            --              is_robot_ready(I) := True;
            --           end if;
            --        end loop;
            --     end EndTransfer;
            end select;
      end loop;
   end robot_manager;
end robot_manager;