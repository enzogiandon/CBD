program ej1;

const
  FIN = 'cemento';

type
  archStrings = file of string[30];



  procedure writeArchEnteros(var arch: archStrings);
  var
    nombre: string;
  begin    
    nombre := '';

    rewrite(arch);
    writeln('Ingrese los materiales: ');
    while (nombre <> FIN) do
    begin
      writeln('Ingrese el siguiente material, para finalizar, escriba "cemento" ');
      readln(nombre);
      Write(arch, nombre);
    end;

    Close(arch);
  end;

var
  nomArch: string;
  arch: archStrings;

begin
  writeln('Practica 1 - Ejercicio 1');
  writeln('Ingrese el nombre del archivo de materiales:');
  readln(nomArch);
  Assign(arch, nomArch);

  writeArchEnteros(arch);

  readln('Fin del programa.');
end.
