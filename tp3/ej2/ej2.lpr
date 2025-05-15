program ej2;

type

  str30 = string[30];
  tVehiculo = record
    codigoVehiculo: integer;
    patente: str30;
    motor: str30;
    cantidadPuertas: integer;
    precio: real;
    descripcion: string[150];
  end;

  tArchivo = file of tVehiculo;

  procedure agregar(var arch: tArchivo; vehiculo: tVehiculo);
  var
    cabecera,regBorrado:tVehiculo;
    posBorrar: integer;

  begin
    reset(arch);

    read(arch,cabecera);

    // Si el archivo no tiene lugares vacios
    if (cabecera.descripcion='0') then begin
      seek(arch,filesize(arch));
      write(arch,vehiculo);
      writeln('Se agregó correctamente el vehículo al final del archivo.');
      close(arch);
      exit;
    end;

    // Busco el lugar a reemplazar

    Val(cabecera.descripcion,posBorrar); // convierto el string en int
    seek(arch,posBorrar);
    read(arch,regBorrado); // Me guardo la posicion del proximo

    // Guardo el vehiculo
    seek(arch,filepos(arch)-1);
    write(arch,vehiculo);
    writeln('Se agregó correctamente el vehículo');


    // Guardo la proxima posicion a borrar en la posicion 0
    cabecera.descripcion:=regBorrado.descripcion; // Indico cual es el proximo a borrar
    seek(arch,0);
    write(arch,cabecera);

    close(arch);

  end;
Procedure eliminar (var arch: tArchivo; codigoVehiculo: integer);
var
  cabecera,aux:tVehiculo;
  encontrado: boolean;

  posBorrar:integer;
  posBorrarPeroEnString:string;

  siguiente:string;

begin
  encontrado:=false;
  reset(arch);

  read(arch,cabecera);

  while not eof(arch) do begin
    read(arch,aux);

    if (aux.codigoVehiculo= codigoVehiculo) then begin
      encontrado:=true;

      // Guardo la posicion a borrar
      posBorrar:= filePos(arch) -1;
      str(posBorrar,posBorrarPeroEnString);


      // Reemplazo en la posicion a borrar, lo que habia en cabecera
      aux.codigoVehiculo:=-1; // borrado
      aux.descripcion:=cabecera.descripcion;
      seek(arch,PosBorrar);
      write(arch,aux);


      // Guardo en la cabecera la ultima posicion borrada
      cabecera.descripcion:=posBorrarPeroEnString;
      seek(arch,0);
      write(arch,cabecera);

      writeln('Se borro correctamente el vehiculo.');


      break;
    end;
  end;


  if (not encontrado) then
     writeln('No existe en el archivo un vehiculo con codigo', codigoVehiculo);

  close(arch);
end;
begin

end.
