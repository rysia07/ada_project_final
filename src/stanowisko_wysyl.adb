with Ada.Text_IO;
with Ada.Strings.Unbounded;
with Dostawy; use Dostawy;

package body stanowisko_wysyl is
   task body StanowiskoWysyl is
      Odebrany_Ladunek : Dostawa;
   begin
      loop
         select
            accept AcceptPrzesylka(id_samochodu : in Integer; Ladunek : in Dostawa) do
               Odebrany_Ladunek := Ladunek;
               Ada.Text_IO.Put_Line("Przyjęto przesyłke od magazynu zawierającą: " & Integer'Image(Odebrany_Ladunek.amount) & " szt. " & Ada.Strings.Unbounded.To_String(Odebrany_Ladunek.jam_type));
            end AcceptPrzesylka;

            Ada.Text_IO.Put_Line("Pakuję towar...");
            delay 3.0;
            Ada.Text_IO.Put_Line("Towar zapakowany. Zamówienie zrealizowane.");
         or
            delay 5.0;
            Ada.Text_IO.Put_Line("Brak nowych przesyłek, czekam...");
         end select;
      end loop;
   end StanowiskoWysyl;
end stanowisko_wysyl;