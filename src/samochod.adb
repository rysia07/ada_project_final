with Ada.Strings.Unbounded;
with Ada.Text_IO;
with stanowisko_rozl; use stanowisko_rozl;
with Dostawy;         use Dostawy;

package body samochod is
   task body samochod_type is
      aktualna_dostawa    : Dostawa;
      docelowe_stanowisko : stanowisko_rozl_ptr;
   begin
      loop
         select
            accept DeliverPackage(Nowa_Dostawa : in Dostawa; Stanowisko : in stanowisko_rozl_ptr) do
               aktualna_dostawa    := Nowa_Dostawa;
               docelowe_stanowisko := Stanowisko;
               Ada.Text_IO.Put_Line("Samochód nr" & Integer'Image(ID) & 
                  " przyjął dostawę o id" & Integer'Image(aktualna_dostawa.id) & 
                  " z ilością " & Integer'Image(aktualna_dostawa.amount) & 
                  " sztuk towaru " & Ada.Strings.Unbounded.To_String(aktualna_dostawa.jam_type));
            end DeliverPackage;

            for i in 1 .. 3 loop
               Ada.Text_IO.Put_Line("Samochód nr" & Integer'Image(ID) & " jedzie do stanowiska rozładunkowego");
               delay 1.0;
            end loop;

            Ada.Text_IO.Put_Line("Samochód nr" & Integer'Image(ID) & " dotarł do stanowiska");
            docelowe_stanowisko.AcceptCargo(ID, aktualna_dostawa);
            Ada.Text_IO.Put_Line("Samochód nr" & Integer'Image(ID) & " zakończył rozładunek towaru");
         or
            delay 3.0;
            Ada.Text_IO.Put_Line("Samochód nr" & Integer'Image(ID) & " czeka na zadanie");
         end select;
      end loop;
   end samochod_type;

end samochod;