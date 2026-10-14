with Ada.Strings.Unbounded;

package robot is
   task type robot_type is
      entry TransferPackage(id: Integer; amount: Integer; jam_type: Ada.Strings.Unbounded.Unbounded_String);
   end robot_type;
end robot;