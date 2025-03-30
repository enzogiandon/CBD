program ej3;

const
  FIN = 'zzz';


  procedure writeArch(var arch: Text);
  var
    i: integer;
    dino: string;
  begin
    i := 1;
    dino := '';
    rewrite(arch);
    while True do
    begin
      writeln('Ingrese el nombre del dinosaurio ', i, ': ');
      readln(dino);
      if (dino = FIN) then break;
      writeln(arch, dino);
      i := i + 1;
    end;
  end;


  procedure readArch(var arch: Text);
  var
    dino: string;
  begin
    dino := '';
    reset(arch);
    if (EOF(arch)) then
      writeln('El archivo esta vacio')
    else
      repeat
        readln(arch, dino);
        writeln(dino);
      until (EOF(arch));
  end;


var
  arch: Text;
  nomArch: string;

begin
  writeln('Práctica 1 - Ejercicio 3');

  writeln('Ingrese el nombre del archivo de nombres de dinosaurios');
  readln(nomArch);
  Assign(arch, nomArch);

  writeArch(arch);
  readArch(arch);

  writeln('FIN DEL PROGRAMA');
  readln();
end.
