{Este es una pavada al lado de los que venían antes.}

program ej6;
const
  FIN= -1;

type
  int=integer;
  str10 = string[10];

  servicio = record
    codMozo: int;
    fecha: str10;
    monto: double;
  end;

  mozo = record
    codMozo: int;
    montoTotal: double;
  end;

  archServicios = file of servicio;

  archMozos = file of mozo;



  procedure leer(var archivo: archServicios;var dato: servicio);
begin
  if (not eof(archivo)) then
     read(archivo,dato)
  else
      dato.codMozo:=FIN;

end;


var
 aServicios:archServicios;
 aMozos:archMozos;


 s:servicio;
 mozoAct:mozo;


begin

   // Asigno nombres y abro los archivos
   assign(aServicios,'servicios.dat');
   reset(aServicios);

   assign(aMozos,'mozos.dat');
   rewrite(aMozos);


   // Leo por primera vez y asumo que no está vacío
   leer(aServicios,s);



   repeat

     // Para cada servicio, sumo según el último mozo.
     mozoAct.codMozo:=s.codMozo;
     mozoAct.montoTotal:=0;
     while (mozoAct.codMozo=s.codMozo) do BEGIN
       mozoAct.montoTotal:=mozoAct.montoTotal+s.monto;
       leer(aServicios,s);
     end;

     write(aMozos,mozoAct);





   until (s.codMozo= FIN);


   close(aMozos);
   close(aServicios);


end.

