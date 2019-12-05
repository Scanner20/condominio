require "test/unit"

class CondominioLasPalomas
  attr_accessor  :dni , :departamento, :mes
  def initialize (dni, departamento, mes)
    @dni, @departamento, @mes = dni, departamento, mes
  end

  def traerDatos
  end

end

class Familiares < CondominioLasPalomas
attr_accessor :nombreFamiliar, :apellidoFamiliar  
  def initialize (dni, departamento, nombreFamiliar, apellidoFamiliar)
    super(dni,departamento, mes)
    @nombreFamiliar, @apellidoFamiliar = nombreFamiliar, apellidoFamiliar

  end

  def traerDatos
    " DNI: #{dni}".ljust(20) + "- Departamento: #{departamento} - Nombre del familiar: #{nombreFamiliar} -  Apellido del Familiar: #{apellidoFamiliar}"
  end
end


class Visitas < CondominioLasPalomas
 attr_accessor  :nombre_visita, :apellido_visita, :fecha 
  def initialize (dni, departamento, nombre_visita, apellido_visita, fecha, mes )
    super(dni,departamento, mes)
    @nombre_visita, @apellido_visita, @fecha  = nombre_visita, apellido_visita, fecha

  end

  def traerDatos
    " DNI: #{dni} - Departamento: #{departamento} - Fecha de visita: #{fecha} #{mes} - Nombre del visitante: #{nombre_visita} #{apellido_visita}"
  end
end 


class Servicios < CondominioLasPalomas
  attr_accessor :agua, :luz , :gasto_mant_areas, :seguridad  
  def initialize (dni, departamento, agua, luz, gasto_mant_areas,seguridad, mes)
    super(dni,departamento, mes)
    @agua, @luz , @gasto_mant_areas, @seguridad  = agua, luz, gasto_mant_areas, seguridad

  end
  def calcularServicios
    agua + luz + gasto_mant_areas + seguridad
  end
  def traerDatos
    "   DNI: #{dni} - Departamento: #{departamento} - Mantenimiento: #{calcularServicios}  - Mes: #{mes}       "
  end

end



class Departamento < CondominioLasPalomas
attr_accessor :nombre_propietario, :apellido_propietario  
  def initialize (dni, departamento, nombre_propietario, apellido_propietario)
    super(dni,departamento, mes)
    @nombre_propietario, @apellido_propietario = nombre_propietario, apellido_propietario
  end

  def traerDatos
    " Nombre del propietario: #{nombre_propietario} - Apellido del propietario: #{apellido_propietario} DNI: #{dni} - Habitación/departamento: #{departamento}}"
  end
end

class Deudores < CondominioLasPalomas
attr_accessor :monto_deuda 
  def initialize (dni, departamento, monto_deuda, mes)
    super(dni,departamento, mes)
    @monto_deuda = monto_deuda
  end
  def montodeuda
   deuda = monto_deuda

  end
  def traerDatos
    "                     DNI: #{dni} - departamento: #{departamento} -  Deuda: #{montodeuda}  "
  end

end



class Administrador

  attr_accessor :arregloservicios, :arreglovisitas, :arreglofamiliares, :arreglodepartamento, :arreglodeudores
  def initialize
    @arregloservicios = []
    @arreglovisitas = []
    @arreglofamiliares = []
    @arreglodepartamento = []
    @arreglodeudores = []
  end
  #---------------------------------------------------------------
  #REGISTRO DE PAGOS DE SERVICIOS
  
    def validar_dni_S(numero)
      tamano = numero.to_s.length
      raise "Servicio no se pudo registrar. Dni inválido" if tamano < 8 || tamano > 8
    end

    def registrarServicios(pagos)
      validar_dni_S(pagos.dni)
      arregloservicios.push(pagos)
    end

    def obtenerservicios(mes)
    temp = []
   
      for serv in arregloservicios
          if serv.mes==mes
          temp.push(serv)
     
          end
      end
      return temp
    end


  def buscarserviciosdni(dni)
        for p in arregloservicios
            if p.dni== dni
            return p
            end
        end
   return nil
  end
    
   def buscarServicioshab(departamento)
        for p in arregloservicios
            if p.departamento == departamento
            return p
            end
        end
    return nil
    end
    
    #------------------------------------------------------------
    #REGISTRO DE VISITANTES

    def validarNombreV(nombrevisita)
    raise "Visita no se pudo registrar. Nombre inválido" if nombrevisita.nombre_visita==nil
    end

    def validarApellidoV(apellidovisita)
    raise "Visita no se pudo registrar. Apellido inválido" if apellidovisita.apellido_visita==nil
    end
    def validar_dni_V(numero)
    tamano = numero.to_s.length
    raise "Visita no se pudo registrar. Dni inválido" if tamano < 8 || tamano > 8
    end

    def registrarvisitas(visita)
        validarNombreV(visita)
        validarApellidoV(visita)
        validar_dni_V(visita.dni)
        arreglovisitas.push(visita)
    end   
    
    def buscarVisitasRangofecha(rang1, rang2)
    temp = []
   
      for visita in arreglovisitas
          if visita.fecha > rang1 && visita.fecha < rang2
              temp.push(visita)
     
          end
      end
      return temp
    end

    def obtenervisitasfecha(fecha)
    temp = []
   
      for visita in arreglovisitas
          if visita.fecha==fecha
          temp.push(visita)
     
          end
      end
      return temp
    end


  def obtenervisitasdni(dni)
    temp = []

    for visita in arreglovisitas
      if visita.dni==dni
        temp.push(visita)
  
      end
    end
    return temp

  end


  def obtenervisitasdepartamento(departamento)
    temp = []
  
    for visita in arreglovisitas
      if visita.departamento==departamento
        temp.push(visita)
  
      end
    end
    return temp
  end

  #REGISTRO DE FAMILIARES
  def validarNombreF(nombrefamiliar)
    raise "Familiar no se pudo registrar. Nombre invalido" if nombrefamiliar.nombreFamiliar==nil
  end

  def validarApellidoF(apellidofamiliar)
      raise "Familiar no se pudo registrar. Apellido invalido" if apellidofamiliar.apellidoFamiliar==nil
  end
  def validar_dni_F(numero)
      tamano = numero.to_s.length
      raise "Familiar se pudo registrar. Dni inválido" if tamano < 8 || tamano > 8
  end

  def registrarFamiliares(familiar)
     validarNombreF(familiar)
     validarApellidoF(familiar)
     validar_dni_F(familiar.dni)
     arreglofamiliares.push(familiar)
  end

      
 
#REGISTRO DE HABITACIÓN
def validarNombreP(nombrepropietario)
    raise "Departamento no se pudo registrar. Nombre inválido" if nombrepropietario.nombre_propietario==nil
end

def validarApellidoP(apellidopropietario)
    raise "Departamento no se pudo registrar. Dni inválido. Apellido inválido" if apellidopropietario.apellido_propietario==nil
end

def validar_dni_P(numero)
  tamano = numero.to_s.length
  raise "Departamento no se pudo registrar. Dni inválido" if tamano < 8 || tamano > 8
end

def registrardepartamento(departamento)
  validar_dni_P(departamento.dni)
  validarNombreP(departamento)
  validarApellidoP(departamento)
  arreglodepartamento.push(departamento)
      
end
#Registro de deudores
  def validardeudores(propietarios)
    if propietarios.monto_deuda > 0
      return true
    else 
      return false
    end
  end 

  def registrarDeudores(propietarios)
    flag = validardeudores(propietarios)
    if flag == false
      return "******El propietario está al día en sus pagos******"
    else
      arreglodeudores.push(propietarios)
      return "******Propietario registrado como deudor***********"
    end
  end
  def buscarDeudoresHab(departamento)
      for p in arreglodeudores
          if p.departamento == departamento
            return p
           end
      end
      return nil
  end
  def obtenerDeudores(monto)
    temp = []
   # puts "--------------Búsqueda de deudores por departamento---------------"
    for propietarios in arreglodeudores
      if propietarios.montodeuda != monto
        temp.push(propietarios)
    #    puts " Departamento: #{propietarios.departamento}  Deuda: #{propietarios.montodeuda}"
      end
    end
    return temp
  end

end

class Factory
  def self.datos_condominio(tipo, *arg)
     case tipo
     when 1
          return Servicios.new(arg[0], arg[1], arg[2], arg[3],arg[4], arg[5], arg[6])
    when  2
          return Visitas.new(arg[0], arg[1], arg[2], arg[3],arg[4],arg[5])
    when  3
          return Familiares.new(arg[0], arg[1], arg[2], arg[3])
    when  4
          return Departamento.new(arg[0], arg[1], arg[2], arg[3])
    when  5
          return Deudores.new(arg[0], arg[1], arg[2], arg[3])
    end  
  end
end
#--------------------------------------------------------------------
class Vista
  def mostrarMensaje(resultado)
      puts resultado
   end

   def imprimirListado(arregloDatosTipo)
      for datos in arregloDatosTipo
         puts datos.traerDatos
      end
   end

   def mostrarDatosCondominio_dni(datos1)
    
    #puts "\n----------------------------Resultado de Busqueda por DNI---------------------------------------------------"
        if datos1!=nil
            puts datos1.traerDatos
        else
             puts "No encontrado!!!"
        end

     #puts"______________________________________________________________________________________________________________"
   end

    def mostrarDatosCondominio_departamento(datos1)
    
    #puts"______________________________________________________________________________________________________________\n"

     #puts "\n----------------------------Resultado de Busqueda por Departamento-------------------------------------------"
          if datos1!=nil
                puts datos1.traerDatos
          else
                puts "No encontrado!!!"
          end
       puts"______________________________________________________________________________________________________________"
   end

#------------------------------------------------------------------------------------------
end
#----------------------------------------------------------------
class Controlador
   attr_accessor :vista, :administrador
   def initialize(vista, administrador)
     @vista = vista
     @administrador = administrador
   end
   def registra_Servicios(tipo, *arg)
      begin
        servicios1= Factory.datos_condominio(tipo, *arg)
        resultado = administrador.registrarServicios(servicios1)
        puts "Servicio registrado con exito!!!!"
      rescue Exception => e
        puts e.message
      end
   end

   def buscar_Servicios_por_Dni(dni)
       #puts"__________________________________________________________________________________________________________________"
       puts "\n----------------------------------Búsqueda de Servicios por dni-----------------------------------------------"
       servicios1 = administrador.buscarserviciosdni(dni)
       vista.mostrarDatosCondominio_dni(servicios1)
   end
    def buscar_Servicios_por_Departamento(departamento)
      puts"______________________________________________________________________________________________________________"
       puts "\n----------------------------------Búsqueda de Servicios por departamento--------------------------------------\n"
       servicios1 = administrador.buscarServicioshab(departamento)
       vista.mostrarDatosCondominio_departamento(servicios1)
   end
   def obtener_Listado_Servicios(mes)
      puts"______________________________________________________________________________________________________________"
       puts "\n-------------------------------------------Lista de servicios-------------------------------------------------"
       arreglo = administrador.obtenerservicios(mes)
       vista.imprimirListado(arreglo)
       puts"______________________________________________________________________________________________________________"
      end

#-------------------------------------------------------
   def registra_Visitas(tipo, *arg)
      begin
        visitas1= Factory.datos_condominio(tipo, *arg)
        resultado = administrador.registrarvisitas(visitas1)
        puts "Visita registrada con exito!!!!"
      rescue Exception => e
        puts e.message
      end
      #vista.mostrarMensaje(resultado)
   end

      def obtener_Listado_Visitas_fecha(tipo, mes)
      puts"______________________________________________________________________________________________________________"
       puts "\n----------------------------------Lista de visitas del día #{tipo} #{mes}---------------------------------------"
       arreglovisitasTipo = administrador.obtenervisitasfecha(tipo)
       vista.imprimirListado(arreglovisitasTipo)
       puts"______________________________________________________________________________________________________________"
      end
      def obtener_Listado_Visitas_Dni(dni)
       puts "\n------------------------------Lista de visitas del día por DNI: #{dni}--------------------------------------"
       arreglovisitasTipo = administrador.obtenervisitasdni(dni)
       vista.imprimirListado(arreglovisitasTipo)
       puts"______________________________________________________________________________________________________________"
    
      end

      def obtener_Listado_Visitas_Departamento(departamento)

       puts "\n-------------------------Lista de visitas del día por Departamento: #{departamento}-------------------------------"
       arreglovisitasTipo = administrador.obtenervisitasdepartamento(departamento)
       vista.imprimirListado(arreglovisitasTipo)
       puts"______________________________________________________________________________________________________________"
      end

        def buscar_visitas_rango_fecha(rang1, rang2)
        puts "\n-------------------------------Lista de visitas entre los dias #{rang1} y #{rang2}-----------------------------------------"
       arreglovisitasTipo = administrador.buscarVisitasRangofecha(rang1, rang2)
       vista.imprimirListado(arreglovisitasTipo)
       puts"______________________________________________________________________________________________________________"
        end
#--------------------------------------------------------------------
#REGISTRA FAMILIARES
    def registra_familiares(tipo, *arg)

      begin
        familiares1= Factory.datos_condominio(tipo, *arg)
        resultado = administrador.registrarFamiliares(familiares1)
        puts "Familiar registrado con exito!!!!"
      rescue Exception => e
        puts e.message
      end
  
   end
#-------------------------------------------------------------------
#REGISTRO DEPARTAMENTOS
   def registra_departamentos(tipo, *arg)
      begin
        dep1= Factory.datos_condominio(tipo, *arg)
        resultado = administrador.registrardepartamento(dep1)
        puts "Departamento empadronado con exito!!!!"
      rescue Exception => e
        puts e.message
      end
   end
#---------------------------------------------------------------------
#REGISTRO DEUDORES

   def registra_deudores(tipo, *arg)
      deudores1= Factory.datos_condominio(tipo, *arg)
      resultado = administrador.registrarDeudores(deudores1)
      vista.mostrarMensaje(resultado)
   end
    def buscar_Deudores_Departamento(deudores)
      puts "------------------------------------Busqueda de deuda por departamento ---------------------------------------"
       deudores1 = administrador.buscarDeudoresHab(deudores)
       vista.mostrarDatosCondominio_departamento(deudores1)
   end

    def obtener_Listado_deudores(monto)

       puts "------------------------------------------Lista de deudores --------------------------------------------------"
       arreglodeudoresTipo = administrador.obtenerDeudores(monto)
       vista.imprimirListado(arreglodeudoresTipo)
       puts"______________________________________________________________________________________________________________"
      end
end
#------------------------------------------------------------------------
class TestDatosCondominio < Test::Unit::TestCase
  
  def setup
    @admin = Administrador.new()
    @vista = Vista.new
    @controlador = Controlador.new(@vista, @admin)

    @controlador.registra_Servicios(1,"38806168", "204 BLOCK A", 50, 200, 70, 90,"Diciembre")
    @controlador.registra_Servicios(1,"6856006", "391 BLOCK B", 37, 140, 80, 85,"Diciembre")
    @controlador.registra_Servicios(1,"22514939", "182 BLOCK C", 62, 150, 75, 70,"Diciembre")

    @controlador.registra_Visitas(2,"44518297", "166 BLOCK A", "" , "Soto", 01, "Noviembre")
    @controlador.registra_Visitas(2,"52852290", "127 BLOCK F", "Davis", "Velasquez", 18, "Noviembre")
    @controlador.registra_Visitas(2,"48472106", "290 BLOCK D", "Abigail", "Campos", 26, "Noviembre")
    @controlador.registra_Visitas(2,"2572340", "157 BLOCK C", "Sergio", "Yi", 28, "Noviembre")

    @controlador.registra_Visitas(2,"46583511", "238 BLOCK D", "Alberto" , "Soto", 4, "Diciembre")
    @controlador.registra_Visitas(2,"33650123", "374 BLOCK F", "Davis", "Velasquez" , 4, "Diciembre")
    @controlador.registra_Visitas(2,"4348262", "139 BLOCK G", nil, "Abigail", 5, "Diciembre")
    @controlador.registra_Visitas(2,"70707771", "304 BLOCK A", "Sergio", nil, 9, "Diciembre")
    @controlador.registra_Visitas(2,"7070777", "305 BLOCK J", "Carlos", "Davalos", 9, "Diciembre")

    @controlador.registra_familiares(3,"30582945", "335 BLOCK B", "Victor", "Torres")
    @controlador.registra_familiares(3,"71259203", "246 BLOCK J", "Ana", "Mejia")
    @controlador.registra_familiares(3,"3164090", "378 BLOCK I", "Claudia", "Cruz")

    @controlador.registra_departamentos(4,"65605106", "379 BLOCK C", "Jenny", "Anicama")
    @controlador.registra_departamentos(4,"42449679", "320 BLOCK D", "Joan", "Torres")
    @controlador.registra_departamentos(4,"6047397", "172 BLOCK H", "Daniel", "Fritsch")

    @controlador.registra_deudores(5,"59850815", "354 BLOCK B", 0, "Noviembre")
    @controlador.registra_deudores(5,"52417793", "131 BLOCK F", 63, "Noviembre")
    @controlador.registra_deudores(5,"34414408", "386 BLOCK D", 41, "Noviembre")

  end


  def testBuscar
        @controlador.buscar_Servicios_por_Departamento("182 BLOCK C")
        @controlador.buscar_Servicios_por_Dni("22514939")
        @controlador.obtener_Listado_Servicios("Diciembre")

        @controlador.obtener_Listado_Visitas_fecha(4, "Diciembre")
        @controlador.obtener_Listado_Visitas_Departamento("238 BLOCK D")
        @controlador.obtener_Listado_Visitas_Dni("46583511")
        @controlador.buscar_visitas_rango_fecha(1,10)

        @controlador.buscar_Deudores_Departamento("131 BLOCK F")
        @controlador.obtener_Listado_deudores(0)
  end
end