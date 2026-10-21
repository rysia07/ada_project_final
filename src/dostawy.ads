with Ada.Strings.Unbounded;

package Dostawy is
   type Dostawa is record
      id: Integer;
      amount: Integer;
      jam_type: Ada.Strings.Unbounded.Unbounded_String;
   end record;
end Dostawy;