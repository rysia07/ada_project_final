with Ada.Strings.Unbounded;
with Ada.Text_IO;
with stanowisko_rozl;
with Dostawy; use Dostawy;
with Ada.Numerics.Float_Random;

package body samochod is
   task body samochod_type is
      Aktualny_Ladunek : Dostawa;
      Gen: Ada.Numerics.Float_Random.Generator;
      random_time : Duration;
   begin
      Ada.Numerics.Float_Random.Reset(Gen);
      loop
         select
            accept DeliverPackage(Ladunek : in Dostawa) do
               Aktualny_Ladunek := Ladunek;
               Ada.Text_IO.Put_Line("[Samochód" & Integer'Image(ID) & 
                  "] Przyjął ładunek o ID" & Integer'Image(Aktualny_Ladunek.id) & 
                  " (" & Integer'Image(Aktualny_Ladunek.amount) & " szt. " & 
                  Ada.Strings.Unbounded.To_String(Aktualny_Ladunek.jam_type) & ")");
            end DeliverPackage;

            for i in 1 .. 3 loop
               Ada.Text_IO.Put_Line("[Samochód" & Integer'Image(ID) & "] Jedzie do stanowiska rozładunkowego...");
               random_time := Duration(Ada.Numerics.Float_Random.Random(Gen)) * 3.0;
               delay random_time;
            end loop;

            Ada.Text_IO.Put_Line("[Samochód" & Integer'Image(ID) & "] Dotarł pod stanowisko, czeka w kolejce na rozładunek.");
            
            stanowisko_rozl.StanowiskoRozl.AcceptCargo(ID, Aktualny_Ladunek);
            
            Ada.Text_IO.Put_Line("[Samochód" & Integer'Image(ID) & "] Odjeżdża po rozładunku.");
         or
            delay 4.0;
            Ada.Text_IO.Put_Line("[Samochód" & Integer'Image(ID) & "] Czeka w bazie na zlecenie.");
         end select;
      end loop;
   end samochod_type;
end samochod;