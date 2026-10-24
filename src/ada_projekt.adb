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


procedure Ada_projekt is
   State : Integer;
   Jam_Type : Ada.Strings.Unbounded.Unbounded_String;
   Jam_Type1 : Ada.Strings.Unbounded.Unbounded_String;

   samochod1 : samochod_type(1);
   samochod2 : samochod_type(2);
   samochod3 : samochod_type(3);
   samochod4 : samochod_type(4);
   samochod5 : samochod_type(5);
   samochod6 : samochod_type(6);
   Dostawa1 : Dostawa := (id => 1, amount => 51, jam_type => Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy"));
   Dostawa2 : Dostawa := (id => 1, amount => 51, jam_type => Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy"));
   Dostawa3 : Dostawa := (id => 1, amount => 51, jam_type => Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy"));
   Dostawa4 : Dostawa := (id => 1, amount => 51, jam_type => Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy"));
   Dostawa5 : Dostawa := (id => 1, amount => 51, jam_type => Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy"));
   zamowienie: zamowienia.order_type;
begin

   Jam_Type := Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy");
   Jam_Type1 := Ada.Strings.Unbounded.To_Unbounded_String("Porzeczkowy");
   samochod1.DeliverPackage(Dostawa1);
   samochod2.DeliverPackage(Dostawa1);
   samochod3.DeliverPackage(Dostawa1);
   samochod4.DeliverPackage(Dostawa1);
   samochod5.DeliverPackage(Dostawa1);
   samochod6.DeliverPackage(Dostawa1);
   --  robot_manager.robot_manager.TransferPackage(Dostawa1);
   --  robot_manager.robot_manager.TransferPackage(Dostawa1);
   --  robot_manager.robot_manager.TransferPackage(Dostawa1);
   --  robot_manager.robot_manager.TransferPackage(Dostawa1);
   --  robot_manager.robot_manager.TransferPackage(Dostawa1);
   --  magazyn.Take(id => 1, amount => 10, jam_type => Jam_Type);
   State := magazyn.Check_state;
   zamowienia.new_order(zamowienie, 1, 100, Jam_Type);
   zamowienia.order.Get(zamowienie);
   zamowienia.order.Get(zamowienie);
end Ada_projekt;
