program ej7;

const
  FIN = maxInt;
  N = 10;

type
  int = integer;
  str10 = string[10];
  str30 = string[30];



  producto = record
    cod: int;
    nombre: str10;
    desc: str30;
    stock: int;
    stockMin: int;
  end;


  venta = record
    codProducto: int;
    cantVendida: double;
  end;


  maestro = file of producto;
  detalle = file of venta;

  vDetalles = array[1..N] of detalle;
  vRegistros = array[1..N] of venta;


  procedure leer(var archivo: detalle; var dato: venta);
  begin
    if (not EOF(archivo)) then
      Read(archivo,dato)
    else
      dato.codProducto := FIN;
  end;

  procedure codMinimo(var vD: vDetalles; var vR: vRegistros; var min: venta);
  var
    i, posMin: int;
  begin

    min := vR[1];
    posMin := 1;

    for i := 2 to N do
      if (vR[i].codProducto < min.codProducto) then
      begin
        min := vR[1];
        posMin := 1;
      end;

    read(vD[posMin],vR[posMin]);

  end;



{
PREGUNTAR SI ESTE MODULO DEBE RECIBIR EL PARAMETRO DEL MAESTRO O
SIMPLEMENTE ESCRIBIRLO, GUARDARLO Y QUE EN EL PROGRAMA PRINCIPAL SE ASIGNE NUEVAMENTE.

}

procedure crearMaestro(var archMaestro:maestro);
var
  txt: Text;
  prodAux:producto;
begin
  assign(txt,'productos.txt');
  reset(txt);

  rewrite(archMaestro);

  while(not eof(txt)) do begin
    readln(txt,prodAux.cod);
    readln(txt,prodAux.nombre);
    readln(txt,prodAux.desc);
    readln(txt,prodAux.stock);
    readln(txt,prodAux.stockMin);


    write(archMaestro,prodAux);
  end;

  close(txt);
  close(archMaestro);
end;


var
  archMaestro:maestro;
  regMaestro:producto;

  vD: vDetalles;
  vR: vRegistros;

  strAux:string;

  min:venta;

begin
  assign(archMaestro,'maestro.dat');
  crearMaestro(archMaestro);

  for i:=1 to N then begin
      readln(strAux);
      assign(vD[i],strAux);

      reset(vD[i]);
      leer(vD[i],vR[i]);
  end;

  reset(archMaestro);

  read(archMaestro,regMaestro);
  codMinimo(vD,vR,min);

  repeat


    ventasProd:=0;

    while(regMaestro.cod = min.codProducto) do begin

    end;



  until (min.cod= FIN);


end.
