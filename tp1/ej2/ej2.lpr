program ej1y2;

type
  archEnteros = file of integer;

  procedure writeArchEnteros(var arch: archEnteros);
  var
    i, numero: integer;
  begin
    i := 1;
    numero := -1;
    rewrite(arch);
    writeln('Ingrese la cantidad de votantes por ciudad, para finalizar, ingrese el 0.'); 

    writeln('Ciudad ', i, ': ');
    ReadLn(numero);
    i:= i+1;
    while (numero <> 0) do
    begin
      writeln('Ciudad ', i, ': ');
      Write(arch, numero);
      i := i + 1;
      readln(numero);
    end;
    Close(arch);
  end;

  procedure readArchEnteros(var arch: archEnteros);
  var
    numero, i, min, max: integer;
  begin
    i := 1;
    numero := 0;
    min := MaxInt;
    max := -1;

    reset(arch);
    if (EOF(arch)) then
      writeln('El archivo esta vacio')
    else
    begin
      repeat
        Read(arch, numero);
        writeln('Ciudad ', i, ': ', numero);
        if (numero < min) then
          min := numero;
        if (numero > max) then
          max := numero;
        i:= i+1;
      until (EOF(arch));

      writeln('La cantidad minima de votantes es ', min, ' y la maxima es ', max);
      Close(arch);

    end;
  end;

var
  nomArch: string;
  arch: archEnteros;

begin
  writeln('Practica 1 - Ejercicio 2');
  writeln('Ingrese el nombre del archivo de votantes:');

  readln(nomArch);
  Assign(arch, nomArch);

  writeArchEnteros(arch);
  readArchEnteros(arch);

  writeln('FIN DEL PROGRAMA');
  readln();
end.
