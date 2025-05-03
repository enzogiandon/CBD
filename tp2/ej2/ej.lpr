program ej;

const
  FIN = '-1';
type
  str30 = string[30];

  disco = record
    codAutor: str30;
    nomAutor: str30;
    nomDisco: str30;
    gen: str30;
    ventas: integer;
  end;

  detalle = file of disco;

  procedure leer(var archivo: detalle; var dato: disco);
  begin
    if (not EOF(archivo)) then
      Read(archivo, dato)
    else
      dato.codAutor := FIN;

  end;


var
  det: detalle;
  txt: Text;
  reg: disco;

  codAct: str30;
  genAct: str30;

  totGen: integer;
  totAutor: integer;
  total: integer;

begin
  reg := default(disco);  // para que no haya warnings

  Assign(det, 'detalle.dat');
  Assign(txt, 'ventas.txt');

  reset(det);
  rewrite(txt);


  total := 0;
  repeat
    leer(det, reg);  // asumo que no esta vacio (para la primera vez)

    // inicializo para el autor actual:
    codAct := reg.codAutor;
    totAutor := 0;
    writeln('Autor: ', reg.nomAutor);

    while (reg.codAutor = codAct) do
    begin
      genAct := reg.gen; // inicializo para el genero actual
      totGen := 0;
      writeln('Genero: ', genAct);

      while (reg.codAutor = codAct) and (reg.gen = genAct) do
      begin
        totGen := totGen + reg.ventas;
        totAutor := totAutor + reg.ventas;
        total := total + reg.ventas;



        // imprimo y guardo para cada disco en ambos archivos
        writeln('Nombre disco: ', reg.nomDisco, '. Cantidad vendida: ', reg.ventas);

        Writeln(txt, 'Nombre del disco: ', reg.nomDisco, '. Nombre del autor: ',
          reg.nomAutor, '. Cantidad vendida: ', reg.ventas);

        leer(det, reg);

      end;
      writeln();
      writeln('Total género: ', totGen);

    end;
    writeln('Total autor:', totAutor);

  until (reg.codAutor = FIN);

  Close(txt);
  Close(det);

end.
