with Dostawy; use Dostawy;

package stanowisko_rozl is
   task type stanowisko_rozl_type(ID: Integer) is
      entry AcceptCargo(id_samochodu: Integer; ladunek: in Dostawa);
   end stanowisko_rozl_type;
   type stanowisko_rozl_ptr is access all stanowisko_rozl_type;
end stanowisko_rozl;