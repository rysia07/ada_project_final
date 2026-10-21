with Ada.Strings.Unbounded;
with Dostawy; use Dostawy;
with stanowisko_rozl; use stanowisko_rozl;

package samochod is
   task type samochod_type(ID: Integer) is
      entry DeliverPackage(Nowa_Dostawa : in Dostawa; Stanowisko : in stanowisko_rozl_ptr);
   end samochod_type;
end samochod;