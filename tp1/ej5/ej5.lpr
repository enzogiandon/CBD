program ej5;

const
  FIN = 'zzz';

type
  flor = record
    num: integer;
    altura: double;
    nomCient: string[30];
    nomVulg: string[20];
    color: string[10];
  end;

  archFlores = file of flor;

  procedure leerFlor(var f: flor);
  begin
    writeln('Lectura de la flor');
    with f do
    begin
      writeln('Ingresa el nombre cientifico');
      readln(nomCient);
      if (nomCient <> FIN) then
      begin
        writeln('Ingresa el numero');
        readln(num);
        writeln('Ingresa la altura');
        readln(altura);
        writeln('Ingresa el nombre vulgar');
        readln(nomVulg);
        writeln('Ingresa el color');
        readln(color);
      end;
    end;
  end;

  procedure writeArch(var arch: archFlores);
  var
    f: flor;
  begin
    rewrite(arch);
    leerFlor(f);
    while (f.nomCient <> fin) do
    begin
      Write(arch, f);
      leerFlor(f);
    end;
    Close(arch);
  end;


  procedure readArch(var arch: archFlores);
  var
    f: flor;
  begin
    reset(arch);
    if EOF(arch) then
      writeln('El archivo esta vacio')
    else
    begin
      writeln('Impresion del archivo: ');
      repeat
        Read(arch, f);
        Write('Numero : ', f.num);
        Write(', Altura: ', f.altura: 0: 2);
        Write(', Nombre Cientifico: ', f.nomCient);
        Write(', Nombre Vulgar: ', f.nomVulg);
        writeln(', Color: ', f.color);
      until EOF(arch);
    end;
    Close(arch);
  end;

  procedure modifArch(var arch: archFlores);
  var
    f: flor;
    pos: integer;
  begin
    pos := 0;
    reset(arch);
    if EOF(arch) then
      writeln('El archivo esta vacio')
    else
    begin
      repeat
        Read(arch, f);
        if (f.nomCient = 'Victoria amazonia') then
        begin
          f.nomCient := 'Victoria amazonica';
          pos := Filepos(arch);
          Seek(arch, pos - 1);
          Write(arch, f);
        end;
      until EOF(arch);
    end;
    Close(arch);
  end;

  procedure anadirFinal(var arch: archFlores);
  var
    f: flor;
  begin
    reset(arch);
    leerFlor(f);
    while (f.nomCient <> FIN) do
    begin
      seek(arch, filesize(arch));
      Write(arch, f);
      leerFlor(f);
    end;
    Close(arch);
  end;

  procedure writeArchTexto(var arch: Text; var archFlor: archFlores);
  var
    f: flor;
  begin
    rewrite(arch);
    reset(archFlor);
    while (not EOF(archFlor)) do
    begin
      Read(archFlor, f);
      with f do
        WriteLn(arch, 'Num: ', num, ', Altura: ', altura: 0: 2, ', Nombre cientifico: ',
          nomCient, ', Nombre vulgar: ', nomVulg, ', Color: ', color);
    end;
    Close(arch);
    Close(archFlor);
  end;


var
  archFlor: archFlores;
  nomArch, nomArchFlor: string;
  arch: Text;
begin
  writeln('Practica 1 - Ejercicio 5');

  writeln('Ingrese el nombre del archivo para las flores');
  readln(nomArchFlor);
  Assign(archFlor, nomArchFlor);

  //PUNTO 5
  writeArch(archFlor);

  //PUNTO B
  readArch(archFlor);
  //PUNTO C
  modifArch(archFlor);
  readArch(archFlor);
  // PUNTO D
  anadirFinal(archFlor);

  readArch(archFlor);

  writeln('Ingrese el nombre del archivo de texto');
  readln(nomArch);
  Assign(arch, nomArch);
  writeArchTexto(arch, archFlor);

  writeln('FIN DEL PROGRAMA');
  readln();

end.
