with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
with magazyn;
with robot;
with stanowisko_rozl; use stanowisko_rozl;
with Dostawy; use Dostawy;
with samochod; use samochod;


procedure Ada_projekt is
   State : Integer;
   Jam_Type : Ada.Strings.Unbounded.Unbounded_String;

   robot1 : robot.robot_type(1);
   robot2 : robot.robot_type(2);
   robot3 : robot.robot_type(3);
   stanowisko1 : stanowisko_rozl.stanowisko_rozl_type(1);
   samochod1 : samochod_type(1);
   Dostawa1 : Dostawa := (id => 1, amount => 40, jam_type => Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy"));
begin
   Jam_Type := Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy");
   samochod1.DeliverPackage(Dostawa1, stanowisko1);
   robot1.TransferPackage(id => 1, amount => 40, jam_type => Jam_Type);
   robot2.TransferPackage(id => 2, amount => 69, jam_type => Jam_Type);
   --  magazyn.Take(id => 1, amount => 10, jam_type => Jam_Type);
   State := magazyn.Check_state;
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
