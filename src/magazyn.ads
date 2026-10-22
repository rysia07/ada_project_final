with Ada.Strings.Unbounded;
with Ada.Containers.Doubly_Linked_Lists;
with Ada.Containers.Indefinite_Doubly_Linked_Lists;

package magazyn is
   package ASU renames Ada.Strings.Unbounded;
   use ASU;
   
   package Int_List is new Ada.Containers.Doubly_Linked_Lists(Element_Type => Integer);
   package String_List is new Ada.Containers.Indefinite_Doubly_Linked_Lists(Element_Type => ASU.Unbounded_String);
   
 
   function Check_state return Integer;
   task centrala is
      entry Take (id: Integer; amount: Integer; jam_type: ASU.Unbounded_String; success : out Boolean; jams_left : out Integer);
      entry Give (id: Integer; amount: Integer; jam_type: ASU.Unbounded_String; success: out Boolean; jams_left: out Integer);
      entry Full(amount: Integer; success: out Boolean; jams_left: out Integer);
   end centrala;
   

private
   max_occupancy: Integer := 100;
   occupancy: Integer := 0;
   id_list: Int_List.List;
   amount_list: Int_List.List;
   type_list: String_List.List;
   

end magazyn;
