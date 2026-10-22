with Dostawy; use Dostawy;

package stanowisko_wysyl is
   task StanowiskoWysyl is
      entry AcceptPrzesylka(id_samochodu : in Integer; Ladunek : in Dostawa);
   end StanowiskoWysyl;
end stanowisko_wysyl;