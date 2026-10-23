with robot;

package robot_manager is
   task robot_manager is
      entry get_free_robot(free_robot: out robot.robot_type);
   end robot_manager;
end robot_manager;