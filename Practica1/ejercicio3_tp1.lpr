program ejercicio3_tp1;
const
  fin='fin';
type
  empleado=record
    nroE:integer;
    nomApe:string[50];
    edad:integer;
    dni:integer;
  end;
  archivo = file of empleado;

procedure leer ( var e:empleado );
begin
  Writeln('________ DATOS EMPLEADO ____________ ');
  Write('NRO: '); readln(e.nroE);
  Write('Nombre y apellido: '); readln(e.nomApe);
  Write('Edad: '); readln(e.edad);
  Write('DNI: '); readln(e.dni);
end;
procedure imprimir (e:empleado);
begin
  Writeln('NRO: ',e.nroE);
  Writeln('Nombre y apellido: ',e.nomApe);
  Writeln('Edad ',e.edad);
  Writeln('DNI: ',e.dni);
  Writeln('______________________________');
end;

procedure moduloUno(var mae:archivo);
var
  nombre:string;     e:empleado;
begin
  Write('Ingrese nombre del archivo a crear: '); readln(nombre);
  assign(mae,nombre);
  rewrite(mae);
  leer(e);
  while(e.nomApe<>fin) do begin
      write('________________________________________');
      write(mae,e);
      leer(e);
  end;
  close(mae);
end;
procedure moduloDos (var mae:archivo);
var
  nombre:string;   e:empleado;
begin
  Writeln('Ingrese nombre del archivo: '); readln(nombre);
  assign(mae,nombre);
  Write('Ingrese nombre o apellido a buscar: '); readln(nombre);

  reset(mae);   read(mae,e);
  While (not EOF(mae)) do begin

      if(nombre=e.nomApe) then begin
         imprimir(e);
      end;
      read(mae,e);
  end;
  close(mae);
end;
procedure moduloTres (var mae:archivo);
var
   e:empleado;   nombre:string;
begin
  Writeln('Ingrese nombre del archivo: '); readln(nombre);
  Write('_____________ Listado _______________ ');
  assign(mae,'empleados.dat');
  reset(mae);  read(mae,e);
  While (not EOF(mae)) do begin
      imprimir(e);
      read(mae,e);
  end;
  close(mae);
end;
procedure moduloCuatro (var mae:archivo);
var
   e:empleado;  nombre:string;
begin
  Writeln('Ingrese nombre del archivo: '); readln(nombre);
  Write('___________ LISTADO MAYORES 70 _______________ ');
  assign(mae,nombre);
  reset(mae);
  read(mae,e);
  While (not EOF(mae)) do begin
      if(e.edad>=70) then begin
         imprimir(e);
      end;
      read(mae,e);
  end;
  close(mae);
end;
function existe (var mae:archivo; cod:integer):boolean;
var
   e:empleado; encontre:boolean;
begin
  reset(mae);   encontre:=false;
  while(not EOF(mae)) and (not (encontre)) do  begin
      read(mae,e);
      if(e.nroE=cod) then begin
         encontre:=true;
      end;
  end;
  close(mae);
  existe:=encontre;
end;
procedure moduloSeis (var mae:archivo);
var
   nombre:string;  e:empleado; seguir:char;
begin
  writeln('Ingresar nombre del archivo: '); readln(nombre);
  assign(mae,nombre);
  writeln('___________________ INGRESAR EMPLEADO ___________________________');
  seguir:='y';
  while (seguir='y') do begin
      leer(e);
      if(existe(mae,e.nroE)) then begin
         Writeln('Ya existe el empleado');
      end else begin
          reset(mae); seek(mae,FileSize(mae));
          write(mae,e); close(mae);
      end;
      Write('Desea agregar otro empleado [y/n]: '); readln(seguir)
  end;
end;
procedure moduloSiete (var mae:archivo);
var
   e:empleado;   nombre:string;   nro,edad:integer;
   ok:boolean;
begin
  Write('Ingrese nombre del archivo: '); readln(nombre);
  assign(mae,nombre);  ok:=false;
  Write('Ingrese numero de empleado: ');readln(nro);
  // aca podemos usar el modulo buscar empleado o
  // recorrer uno por uno a ver sin coincide y cambiar
  reset(mae);
  while (not EOF(mae)) and (not(ok)) do begin
      read(mae,e);
      if(e.nroE=nro) then begin
         Write('Ingrese nueva edad: '); readln(edad);
         e.edad:=edad;
         seek(mae,filepos(mae)-1);
         write(mae,e);  ok:=true;
      end;
  end;
  if (not (ok)) then begin
     writeln('No se encontró el empleado');
  end;
  close(mae);
end;
procedure moduloOcho (var mae:archivo);
var
   e:empleado; txt:text;  nombre:string;
begin
  Write('Ingrese nombre del archivo a abrir: ');    readln(nombre);
  assign(mae,nombre);
  reset(mae);
  assign(txt,'todos_empleados.txt');
  rewrite(txt);
  While (not EOF(mae)) do begin
      read(mae,e);
      writeln(txt, 'NroE: ', e.nroE ,
      'Edad: ', e.edad ,
      'Dni: ', e.dni ,
      'NyA: ', e.nomApe);
  end;
   close(mae); close(txt);
end;
procedure moduloNueve(var mae:archivo);
var
   e:empleado; txt:text;  nombre:string;
begin
  Write('Ingrese nombre del archivo a abrir: ');    readln(nombre);
  assign(mae,nombre);
  reset(mae);
  assign(txt,'FaltaDniEmpleado.txt');
  rewrite(txt);
  While (not EOF(mae)) do begin
      read(mae,e);
      if(e.dni=00) then begin
        writeln(txt, 'NroE: ', e.nroE ,
        ' |  Edad: ', e.edad ,
        ' |  Dni: ', e.dni ,
        ' |  NyA: ', e.nomApe);
      end;
  end;
  close(mae); close(txt);

end;

procedure menu ();
var mae:archivo;  opc:integer;
begin
  Writeln(' OPCIONES ');
  Writeln('1 --->  Crear archivo EMPLEADOS y completarlo ') ;
  Writeln('2 --->  Listar por nombre y apellido especifico');
  Writeln('3 --->  Listar todos los empleados ');
  Writeln('4 --->  Listar empleados mayores a 70 años ');
  Writeln('5 --->  Cerrar programa ');
  Writeln('6 --->  Agregar empleado ');
  Writeln('7 --->  Modificar edad de empleado ');
  Writeln('8 --->  Exportar datos a archivo.txt ');
  Writeln('9 --->  Exportar empleados que le falten dni a txt ');

  Write('Ingrese opcion ------> : '); readln(opc);
  case opc of
       1: moduloUno(mae);
       2: moduloDos(mae);
       3: moduloTres(mae);
       4: moduloCuatro(mae);
       5: Writeln('Cerrando Programa.....');
       6: moduloSeis(mae);
       7: moduloSiete(mae);
       8: moduloOcho(mae);
       9: moduloNueve(mae);
  else
    Writeln('Opcion invalida. Vuelva a seleccionar');
    menu();
  end;
  if(opc<>5) then begin
             menu();
  end;
end;


begin
  menu();
  readln();

end.

