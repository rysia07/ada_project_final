with Ada.Strings.Unbounded;
with robot; use robot;

package ladowarka is
   task ladowarka is
      entry ChargeRobot(is_free: out Boolean);
      entry EndCharging;
   end ladowarka;

end ladowarka;
