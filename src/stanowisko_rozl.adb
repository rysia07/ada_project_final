with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Dostawy; use Dostawy;

package body stanowisko_rozl is
   task body stanowisko_rozl_type is
      current_id : Integer;
      current_amount : Integer;
      current_jam_type: Ada.Strings.Unbounded.Unbounded_String;
   begin
      loop
         select
            accept AcceptCargo(id_samochodu: Integer; ladunek: in Dostawa) do
               current_id := ladunek.id;
               current_amount := ladunek.amount;
               current_jam_type := ladunek.jam_type;
               Ada.Text_IO.Put_Line("Stanowisko rozładunku nr" & Integer'Image(ID) &
               "przyjęło samochód nr" & Integer'Image(id_samochodu) & 
               " przyjęło" & Integer'Image(current_amount) & " sztuk towaru "
               & Ada.Strings.Unbounded.To_String(current_jam_type));
            end AcceptCargo;
            Ada.Text_IO.Put_Line("Stanowisko rozładunku nr" & Integer'Image(ID) & " rozładowuje towar");
            delay 3.0;
            Ada.Text_IO.Put_Line("Stanowisko rozładunku nr" & Integer'Image(ID) & " zakończyło rozładunek towaru");
         or
            delay 3.0;
            Ada.Text_IO.Put_Line("Brak nowych dostaw w " & "stanowisku rozładunkowym nr" & Integer'Image(ID));
         end select;
      end loop;
   end stanowisko_rozl_type;
end stanowisko_rozl;