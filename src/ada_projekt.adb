with Ada.Text_IO;
use Ada.Text_IO;
with Ada.Strings.Unbounded;
with magazyn;


procedure Ada_projekt is
   State : Integer;
   Jam_Type : Ada.Strings.Unbounded.Unbounded_String;
begin
   Jam_Type := Ada.Strings.Unbounded.To_Unbounded_String("Truskawkowy");
   magazyn.Take(id => 1, amount => 10, jam_type => Jam_Type);
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
