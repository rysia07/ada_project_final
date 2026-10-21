with Dostawy; use Dostawy;

package samochod is
   task type samochod_type(ID : Integer) is
      entry DeliverPackage(Ladunek : in Dostawa);
   end samochod_type;
end samochod;