with Ada.Strings.Unbounded;

package magazyn is
   package ASU renames Ada.Strings.Unbounded;
   
   function Take(id, amount: Integer; jam_type:ASU.Unbounded_String);
   function Check_state return Integer;

private
   occupancy: Integer := 0;
   

end magazyn;
