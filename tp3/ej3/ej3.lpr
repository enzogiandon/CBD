program ej3;

type
  int = integer;
  str30 = string[30];
  str150 = string[150];

  producto = record
    codigo: int;
    nombre: str30;
    descrip: str150;
    stock: int;
  end;


  archProductos = file of producto;


const

  FIN = -1;
  cabeceraInicial: producto = (
  codigo: -1;
  nombre: '';
  descrip: '';
  stock: -1;
  );


  // PUNTO A
  procedure crearBinario(var archTxt: Text);
  var
    aux: producto;
    archBinario: archProductos;
  begin
    reset(archTxt);

    Assign(archBinario, 'productos.dat');

    rewrite(archBinario);

    while (not EOF(archTxt)) do
    begin
      readln(archTxt, aux.codigo);
      readln(archTxt, aux.nombre);
      readln(archTxt, aux.descrip);
      readln(archTxt, aux.stock);


      Write(archBinario, aux);
    end;
    Close(archBinario);

  end;

  // PUNTO B
  procedure bajaLogica(var arch: archProductos);
  var
    codObsoleto: int;
    aux: producto;
  begin
    reset(arch);
    readln(codObsoleto);
    while (codObsoleto <> FIN) do
    begin

      while (not EOF(arch)) do
      begin
        Read(arch, aux);

        // Cuando lo encuentro, lo cambio por su negativo
        if (aux.codigo = codObsoleto) then
        begin
          aux.stock := -aux.stock;
          seek(arch, filepos(arch) - 1);
          Write(arch, aux);
          break; // dejo de buscar
        end;
      end;


      seek(arch, 0);
      readln(codObsoleto);
    end;

    Close(arch);
  end;



  // PUNTO C
  procedure leerProducto(var p: producto);
  begin
    with p do
    begin
      readln(codigo);
      if (codigo = fin) then exit;
      readln(nombre);
      readln(stock);
      readln(descrip);
    end;
  end;

 
{
Recien cuando llegue al punto g) cai, creo que había que agregar siempre al
final sin recuperar las bajas logicas, pero bueno, fue.
}
  procedure alta(var arch: archProductos);
  var
    aux, nuevoP: producto;
  begin

    reset(arch);

    leerProducto(nuevoP);


    while (nuevoP.codigo <> FIN) do
    begin

      // Mientras no llegue al final del archivo, busco un stock negativo.
      while (not EOF(arch)) do
      begin
        Read(arch, aux);
        if (aux.stock < 0) then
        begin
          // Si encuentro un negativo, dejo de buscar y lo reemplazo.
          seek(arch, filepos(arch) - 1);
          break;
        end;
      end;

      // Escribo (si estoy en eof escribo uno nuevo, sino, reemplazo).
      Write(arch, nuevoP);

      leerProducto(nuevoP);
    end;

    Close(arch);
  end;



  // PUNTO D

  procedure bajaLogicaListaInvertida(var arch: archProductos);
  var
    codObsoleto: int;
    cabecera, aux: producto;
  begin
    reset(arch);

    // Guardo la cabecera
    Read(arch, cabecera);

    // Busco un codigo
    readln(codObsoleto);

    while (codObsoleto <> FIN) do
    begin

      while (not EOF(arch)) do
      begin
        Read(arch, aux);

        if (aux.codigo = codObsoleto) then
        begin

          seek(arch, filepos(arch) - 1);

          // Añado a la pila un nuevo tope, y acomodo el tope anterior como siguiente.
          aux.stock := cabecera.stock;

          cabecera.stock := filepos(arch);

          // Reemplazo en la posición actual, y en la inicial.
          Write(arch, aux);

          seek(arch, 0);
          Write(arch, cabecera);

          break; // Dejo de buscar
        end;
      end;

      readln(codObsoleto);
    end;

    Close(arch);
  end;

  // PUNTO E


  procedure altaInvertida(var arch: archProductos);
  var
    aux, nuevoP,cabecera: producto;
  begin

    reset(arch);

    leerProducto(nuevoP);

    // Asumo por enunciado que el archivo tiene por lo menos una cabecera
    Read(arch, cabecera);

    while (nuevoP.codigo <> FIN) do
    begin



      // Asumo que si stock < 0, indica que la pila está vacía
      if (cabecera.stock >= 0) then
      begin

        // Guardo el siguiente en la cabecera antes de pisarlo
        seek(arch, cabecera.stock);
        read(arch, aux);

        cabecera.stock:=aux.stock;

        // Escribo el nuevo producto en el archivo
        seek(arch, filePos(arch)-1);
        write(arch,nuevoP);

        Write(arch, nuevoP);


        // Escribo la nueva cabecera
        seek(arch,0);
        write(arch,cabecera);

      end
      else
      begin // Si la pila está vacía, escribo en el final del archivo
        seek(arch,fileSize(arch));
        write(arch,nuevoP);
      end;
      leerProducto(nuevoP);
    end;

    Close(arch);
  end;

 
  // PUNTO F
  procedure crearBinarioInvertida(var archTxt: Text);
  var
    aux: producto;
    archBinario: archProductos;
  begin
    reset(archTxt);

    Assign(archBinario, 'productos.dat');

    rewrite(archBinario);

    // Solo cambia que el primer dato será la cabecera inicial (constante)
    write(archBinario,cabeceraInicial);

    while (not EOF(archTxt)) do
    begin
      readln(archTxt, aux.codigo);
      readln(archTxt, aux.nombre);
      readln(archTxt, aux.descrip);
      readln(archTxt, aux.stock);


      Write(archBinario, aux);
    end;
    Close(archBinario);
  end;


begin

end.

{
PUNTO G (no te regales)

La principal ventaja de la técnica de recuperación de espacio libre es el
aprovechamiento de los espacios que se van dejando, cosa que ahorra el
crecimiento indefinido del tamaño del archivo.





}
