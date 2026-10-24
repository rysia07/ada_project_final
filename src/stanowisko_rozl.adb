with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Dostawy; use Dostawy;
with robot_manager;

package body stanowisko_rozl is
   task body StanowiskoRozl is
      Odebrany_Ladunek : Dostawa;
   begin
      loop
         select
            accept AcceptCargo(id_samochodu : in Integer; Ladunek : in Dostawa) do
               Odebrany_Ladunek := Ladunek;
               Ada.Text_IO.Put_Line("[Stanowisko Rozładunkowe] Przyjęto samochód nr" & Integer'Image(id_samochodu) & 
                  " (Dostawa ID:" & Integer'Image(Odebrany_Ladunek.id) & 
                  ", ilość:" & Integer'Image(Odebrany_Ladunek.amount) & 
                  ", towar: " & Ada.Strings.Unbounded.To_String(Odebrany_Ladunek.jam_type) & ")");
            end AcceptCargo;

            Ada.Text_IO.Put_Line("[Stanowisko Rozładunkowe] Trwa rozładunek towaru...");
            delay 3.0;
            Ada.Text_IO.Put_Line("[Stanowisko Rozładunkowe] Zakończono rozładunek towaru.");
            robot_manager.robot_manager.TransferPackage(Odebrany_Ladunek);
         or
            delay 5.0;
            Ada.Text_IO.Put_Line("[Stanowisko Rozładunkowe] Brak nowych dostaw - oczekiwanie...");
         end select;
      end loop;
   end StanowiskoRozl;
end stanowisko_rozl;