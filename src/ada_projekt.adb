with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
with magazyn;
with robot;
with stanowisko_rozl; use stanowisko_rozl;
with Dostawy; use Dostawy;
with samochod; use samochod;
with zamowienia;


procedure Ada_projekt is
   State : Integer;
   Jam_Type : Ada.Strings.Unbounded.Unbounded_String;
   Jam_Type1 : Ada.Strings.Unbounded.Unbounded_String;

   robot1 : robot.robot_type(1);
   robot2 : robot.robot_type(2);
   robot3 : robot.robot_type(3);
   samochod1 : samochod_type(1);
   Dostawa1 : Dostawa := (id => 1, amount => 2, jam_type => Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy"));
   Dostawa2 : Dostawa := (id => 1, amount => 2, jam_type => Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy"));
   Dostawa3 : Dostawa := (id => 1, amount => 2, jam_type => Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy"));
   Dostawa4 : Dostawa := (id => 1, amount => 2, jam_type => Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy"));
   Dostawa5 : Dostawa := (id => 1, amount => 2, jam_type => Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy"));
   zamowienie: zamowienia.order_type;
begin

   Jam_Type := Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy");
   Jam_Type1 := Ada.Strings.Unbounded.To_Unbounded_String("Porzeczkowy");
   samochod1.DeliverPackage(Dostawa1);
   robot1.TransferPackage(Dostawa1);
   robot2.TransferPackage(DOstawa2);
   robot3.TransferPackage(Dostawa3);
   robot1.TransferPackage(Dostawa1);
   --  magazyn.Take(id => 1, amount => 10, jam_type => Jam_Type);
   State := magazyn.Check_state;
   zamowienia.new_order(zamowienie, 1, 100, Jam_Type);
   zamowienia.order.Get(zamowienie);


   --     type Date is record
   --        Day : Integer range 1 .. 31;
   --        Year : Integer range 1 .. 3000 := 2032;
   --     end record;
   --     Meow : Integer := 5;
   --     Test : Date;
   --
   --     task type Robot_Type;
   --     task body Robot_Type is
   --     begin
   --
   --     for I in 1 .. 5 loop
   --        Put_Line("Robot pracuje");
   --        delay 1.0;
   --     end loop;
   --
   --     end Robot_Type;
   --
   --     Hau : Robot_Type;
   --  begin
   --     Test.Day := 20;
   --     Meow := 6;
   --     if Meow = 5 then
   --        Put_Line("Kij ci w oko");
   --     else
   --        Put_Line("Hello Ada!" & Integer'Image(Meow));
   --     end if;
   --     Put_Line(Integer'Image(Test.Day) & Integer'Image(Test.Year));

end Ada_projekt;
