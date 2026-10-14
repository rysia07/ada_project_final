with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Containers.Indefinite_Doubly_Linked_Lists;

package body magazyn is
   procedure Take (id: Integer; amount: Integer; jam_type:ASU.Unbounded_String) is
   begin
      id_list.Append(id);
      amount_list.Append(amount);
      type_list.Append(jam_type);
      occupancy := occupancy + amount;
   end Take;
   
   function Check_state return Integer is
   begin
      Ada.Text_IO.Put_Line("Stan magazynu: " & Integer'Image(occupancy));
      Ada.Text_IO.Flush;
      return occupancy;
   end Check_state;

   

end magazyn;
