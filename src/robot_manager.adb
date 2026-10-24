with robot;
with Dostawy;

package body robot_manager is
   task body robot_manager is
      --  type robot_bounds is range 0..5;
      robot1 : robot.robot_type(1);
      robot2 : robot.robot_type(2);
      robot3: robot.robot_type(3);
      robot4 : robot.robot_type(4);
      robot5 : robot.robot_type(5);
      robot_index : Integer := 0;
      temp_ready : Boolean := False;
      current_dostawa : Dostawy.Dostawa;
      --  type robot_array is array(robot_bounds) of robot.robot_type;
      --  robots : robot_array := (robot1, robot2, robot3, robot4, robot5);
      --  temp_robot: robot.robot_type;
   begin
      loop
         select
            accept TransferPackage(dostawa: Dostawy.Dostawa) do
               current_dostawa := dostawa;
            end TransferPackage;
            while temp_ready = False loop
                  if robot_index = 0 then
                     robot1.can_transfer(temp_ready);
                     robot_index := 1;
                  elsif robot_index = 1 then
                     robot2.can_transfer(temp_ready);
                     robot_index := 2;
                  elsif robot_index = 2 then
                     robot3.can_transfer(temp_ready);
                     robot_index := 3;
                  elsif robot_index = 3 then
                     robot4.can_transfer(temp_ready);
                     robot_index := 4;
                  elsif robot_index = 4 then
                     robot5.can_transfer(temp_ready);
                     robot_index := 0;
                  end if;
            end loop;
            if temp_ready then
                  if robot_index = 1 then
                     robot1.TransferPackage(current_dostawa);
                  elsif robot_index = 2 then
                     robot2.TransferPackage(current_dostawa);
                  elsif robot_index = 3 then
                     robot3.TransferPackage(current_dostawa);
                  elsif robot_index = 4 then
                     robot4.TransferPackage(current_dostawa);
                  elsif robot_index = 0 then
                     robot5.TransferPackage(current_dostawa);
                  end if;
            end if;
            temp_ready := False;
            robot_index := 0;
            --   do
               --  for i in robot_bounds loop
               --     temp_robot := robots(i);
               --     if temp_robot.is_ready(20) and not temp_robot.is_at_work then
               --        free_robot := temp_robot;
               --     end if;
               --  end loop;
            --  end get_free_robot;
         end select;
      end loop;
   end robot_manager;
end robot_manager;