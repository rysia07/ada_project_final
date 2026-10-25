with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
with magazyn;
with robot;
with robot_manager;
with stanowisko_rozl; use stanowisko_rozl;
with Dostawy; use Dostawy;
with samochod; use samochod;
with zamowienia;
with ladowarka; 
with Ada.Numerics.Float_Random;

procedure Ada_projekt is
   Action_count : Integer := 4;
   State : Integer;
   Jam_Type_Str : Ada.Strings.Unbounded.Unbounded_String; -- Zmiana nazwy ze względu na konflikt
   Jam_Type1 : Ada.Strings.Unbounded.Unbounded_String;
   Jam_Type2 : Ada.Strings.Unbounded.Unbounded_String;
   Jam_Type3 : Ada.Strings.Unbounded.Unbounded_String;

   samochod1 : samochod_type(1);
   samochod2 : samochod_type(2);
   samochod3 : samochod_type(3);
   samochod4 : samochod_type(4);
   samochod5 : samochod_type(5);
   samochod6 : samochod_type(6);
   Dostawa1 : Dostawa;
 
   zamowienie: zamowienia.order_type;
   
   Gen: Ada.Numerics.Float_Random.Generator;
   OD : Float;
   jam_type : float;
   amount : Integer;
begin
   Ada.Numerics.Float_Random.Reset(Gen);
   
   Jam_Type_Str := Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy");
   Jam_Type1 := Ada.Strings.Unbounded.To_Unbounded_String("Porzeczkowy");
   Jam_Type2 := Ada.Strings.Unbounded.To_Unbounded_String("Malinowy");
   Jam_Type3 := Ada.Strings.Unbounded.To_Unbounded_String("Brzoskwiniowy");

   while Action_count /= 0 loop
      OD := Ada.Numerics.Float_Random.Random(Gen);
      jam_type := Ada.Numerics.Float_Random.Random(Gen);
      amount :=  Integer(Ada.Numerics.Float_Random.Random(Gen) * 100.0);
      Dostawa1.amount := amount;

      if jam_type <= 0.25 then
         Dostawa1.jam_type := Jam_Type_Str;
      elsif jam_type <= 0.5 then
         Dostawa1.jam_type := Jam_Type1;
      elsif jam_type <= 0.75 then
         Dostawa1.jam_type := Jam_Type2;
      else
         Dostawa1.jam_type := Jam_Type3;
      end if;
         samochod1.DeliverPackage(Dostawa1);
         samochod2.DeliverPackage(Dostawa1);
         samochod3.DeliverPackage(Dostawa1);
         samochod4.DeliverPackage(Dostawa1);
         samochod5.DeliverPackage(Dostawa1);
         samochod6.DeliverPackage(Dostawa1);

      if OD <= 0.5 then 
         samochod1.DeliverPackage(Dostawa1);
         samochod2.DeliverPackage(Dostawa1);
         samochod3.DeliverPackage(Dostawa1);
         samochod4.DeliverPackage(Dostawa1);
         samochod5.DeliverPackage(Dostawa1);
         samochod6.DeliverPackage(Dostawa1);
      else 
         zamowienia.new_order(zamowienie, Action_count, amount, Dostawa1.jam_type);
         zamowienia.order.Get(zamowienie);
      end if; 
   
      Action_count := Action_count - 1;
   end loop;
   
   State := magazyn.Check_state;
   
end Ada_projekt;
