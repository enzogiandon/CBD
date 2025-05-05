program ej6;

const
  nomArchTexto = 'libros.txt';

type
  libro = record
    ISBN: string[13];
    titulo: string[30];
    genero: string[20];
    editorial: string[20];
    anio: 0..2100;

  end;

  archLibros = file of libro;

  procedure writeArchLibro(var archTexto: Text; var archLibro: archLibros);
  var
    l: libro;
  begin
    rewrite(archLibro);
    reset(archTexto);
    if EOF(archTexto) then
      writeln('El archivo esta vacio')
    else
    begin
      repeat
        Readln(archTexto, l.ISBN, l.titulo);
        Readln(archTexto, l.anio, l.editorial);
        Readln(archTexto, l.genero);

        Write(archLibro, l);
      until EOF(archTexto);

    end;
    Close(archTexto);
    Close(archLibro);
  end;

  procedure ImprimirLibro(l: libro);
  begin
    Writeln('ISBN: ', l.ISBN);
    Writeln('Titulo: ', l.titulo);
    Writeln('Genero: ', l.genero);
    Writeln('Editorial: ', l.editorial);
    Writeln('Anio: ', l.anio);
    Writeln('----------------------');
  end;

  procedure readArchLibro(var archLibro: archLibros);
  var
    l: libro;
  begin
    Writeln('----------------------');
    writeln('IMPRESION DEL ARCHIVO');
    reset(archLibro);
    if EOF(archLibro) then
      writeln('El archivo esta vacio')
    else
    begin
      repeat
        Read(archLibro, l);
        ImprimirLibro(l);
      until EOF(archLibro);

    end;
    Close(archLibro);
  end;

  procedure leerLibro(var l: libro);
  begin
    Writeln('Lectura del nuevo libro:');
    Write('ISBN: ');
    Readln(l.ISBN);
    Write('Titulo: ');
    Readln(l.titulo);
    Write('Genero: ');
    Readln(l.genero);
    Write('Editorial: ');
    Readln(l.editorial);
    Write('Anio: ');
    Readln(l.anio);
  end;


  procedure agregarLibro(var archLibro: archLibros);
  var
    l: libro;
  begin
    reset(archLibro);
    leerLibro(l);
    seek(archLibro, Filesize(archLibro));
    Write(archLibro, l);
    Close(archLibro);

  end;


  procedure modifArchLibro(var archLibro: archLibros; isbn: string);
  var
    aux: libro;
    encontrado: boolean;
  begin
    encontrado := False;
    reset(archLibro);
    if EOF(archLibro) then
      writeln('Archivo vacio')
    else
      repeat
        Read(archLibro, aux);
        if (aux.isbn = isbn) then
        begin
          leerLibro(aux);
          seek(archLibro, filepos(archlibro) - 1);
          Write(archLibro, aux);
          encontrado := True;
        end;

      until (EOF(archLibro) or encontrado);

    Close(archLibro);
  end;

var
  archTexto: Text;
  archLibro: archLibros;
  nomArchLibro, isbn: string;

begin
  writeln('Practica 1 - Ejercicio 6');

  writeln('Ingrese el nombre del archivo binario.');
  readln(nomArchLibro);

  Assign(archTexto, nomArchTexto);
  Assign(archLibro, nomArchLibro);

  writeArchLibro(archTexto, archLibro);
  readArchLibro(archLibro);

  agregarLibro(archLibro);
  readArchLibro(archLibro);

  writeln('Ingrese el isbn del libro a modificar: ');
  readln(isbn);
  modifArchLibro(archLibro, isbn);

  readArchLibro(archLibro);
  writeln('FIN DEL PROGRAMA');
  readln();

end.
