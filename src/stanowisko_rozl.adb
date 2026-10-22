with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Dostawy; use Dostawy;

package body stanowisko_rozl is
   task body StanowiskoRozl is
      Odebrany_Ladunek : Dostawa;
   begin
      loop
         select
            accept AcceptCargo(id_samochodu : in Integer; Ladunek : in Dostawa) do
               Odebrany_Ladunek := Ladunek;
               Ada.Text_IO.Put_Line("[Stanowisko] Przyjęto samochód nr" & Integer'Image(id_samochodu) & 
                  " (Dostawa ID:" & Integer'Image(Odebrany_Ladunek.id) & 
                  ", ilość:" & Integer'Image(Odebrany_Ladunek.amount) & 
                  ", towar: " & Ada.Strings.Unbounded.To_String(Odebrany_Ladunek.jam_type) & ")");
            end AcceptCargo;

            Ada.Text_IO.Put_Line("[Stanowisko] Trwa rozładunek towaru...");
            delay 3.0;
            Ada.Text_IO.Put_Line("[Stanowisko] Zakończono rozładunek towaru.");
         or
            delay 5.0;
            Ada.Text_IO.Put_Line("[Stanowisko] Brak nowych dostaw - oczekiwanie...");
         end select;
      end loop;
   end StanowiskoRozl;
end stanowisko_rozl;