with robot;

package body robot_manager is
   task body robot_manager is
      --  type robot_bounds is range 0..5;
      --  robot1 : robot.robot_type(1);
      --  robot2 : robot.robot_type(2);
      --  robot3: robot.robot_type(3);
      --  robot4 : robot.robot_type(4);
      --  robot5 : robot.robot_type(5);
      --  type robot_array is array(robot_bounds) of robot.robot_type;
      --  robots : robot_array := (robot1, robot2, robot3, robot4, robot5);
      --  temp_robot: robot.robot_type;
   begin
      loop
         select
            accept get_free_robot(free_robot: out robot.robot_type);
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