program ej4;

const
  ruta = '../ej2/votantes';


type
  archEnteros = file of integer;

  procedure generarText(var arch: Text; var archInt: archEnteros);
  var
    numero: integer;
  begin
    numero := 0;
    reset(archInt);
    if EOF(archInt) then
      writeln('El archivo esta vacio')
    else
    begin
      rewrite(arch);
      repeat
        Read(archInt, numero);
        writeln(arch, numero);
      until EOF(archInt);
      Close(arch);
      Close(archInt);
    end;
  end;

// Para probar
  procedure leerArchivo(var arch: Text);
  var
    num: integer;
  begin
    reset(arch);
    if EOF(arch) then
      writeln('El archivo esta vacio')
    else
    begin
      repeat
        readln(arch, num);
        writeln(num);
      until EOF(arch);
      Close(arch);
    end;
  end;

var
  arch: Text;
  archInt: archEnteros;

  nomArch: string;
begin
  writeln('Practica 1 - Ejercicio 4');

  writeln('Ingrese el nombre del archivo de texto: ');
  readln(nomArch);

  Assign(arch, nomArch);
  Assign(archInt, ruta);

  generarText(arch, archInt);

  // Chequeo:
  leerArchivo(arch);


  writeln('FIN DEL PROGRAMA');
  readln();
end.
