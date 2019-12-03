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
    def validar_dni(numero)
    tamano = numero.to_s.length
        if  tamano < 8 || tamano > 8
         return false
        else 
        return true
    
        end
    end

    def registrarServicios(pagos)

      begin  
          flag = validar_dni(pagos.dni)

              if flag == false
                  return "Servicio no se pudo registrar. Dni inválido"
              else
                  arregloservicios.push(pagos)
                return "Servicio registrado con exito!!!!"
              end
          end
     rescue Exception => e
        puts e.message
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

    def registrarvisitas(visita)
    flag = validar_dni(visita.dni)
        if flag == false
            return "Visita no se pudo registrar. Dni inválido"
        else
            arreglovisitas.push(visita)
          return "Visita registrada con exito!!!!"
        end
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
  def registrarFamiliares(familiar)
    flag = validar_dni(familiar.dni)
        if flag == false
            return "Familiar no se pudo registrar. Dni inválido"
        else
            arreglofamiliares.push(familiar)
          return "Familiar registrado con exito!!!!"
        end
    end
      
 
#REGISTRO DE HABITACIÓN
  def registrardepartamento(departamento)
      flag = validar_dni(departamento.dni)
        if flag == false
            return "Departamento no se pudo registrar. Dni inválido"
        else
            arreglodepartamento.push(departamento)
          return "Departamento registrado con exito!!!!"
        end
      
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
      servicios1= Factory.datos_condominio(tipo, *arg)
    
      resultado = administrador.registrarServicios(servicios1)
      vista.mostrarMensaje(resultado)
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
      visitas1= Factory.datos_condominio(tipo, *arg)
      resultado = administrador.registrarvisitas(visitas1)
      vista.mostrarMensaje(resultado)
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
#REGISTRA VISITAS
   def registra_familiares(tipo, *arg)
    
      familiares1= Factory.datos_condominio(tipo, *arg)
      resultado = administrador.registrarFamiliares(familiares1)
      vista.mostrarMensaje(resultado)
   end
#-------------------------------------------------------------------
#REGISTRO DEPARTAMENTOS

   def registra_departamentos(tipo, *arg)
      dep1= Factory.datos_condominio(tipo, *arg)
      resultado = administrador.registrardepartamento(dep1)
      vista.mostrarMensaje(resultado)
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

    @controlador.registra_Servicios(1,"66224100", "357 BLOCK G", 45, 125, 64, 100,"Noviembre")
    @controlador.registra_Servicios(1,"60110760", "315 BLOCK H", 35, 150, 69, 110,"Noviembre")
    begin
        @controlador.registra_Servicios(1,5323200, "148 BLOCK O", 60, 110, 80, 95,"Noviembre")#PARA PRUEBA DE EXCEPCIONES
    rescue Exception => e
        puts e.message
    end       

    @controlador.registra_Visitas(2,"44518297", "166 BLOCK A", "" , "Soto", 01, "Noviembre")
    @controlador.registra_Visitas(2,"52852290", "127 BLOCK F", "Davis", "Velasquez", 18, "Noviembre")
    @controlador.registra_Visitas(2,"48472106", "290 BLOCK D", "Abigail", "Campos", 26, "Noviembre")
    @controlador.registra_Visitas(2,"2572340", "157 BLOCK C", "Sergio", "Yi", 28, "Noviembre")

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
        @controlador.buscar_Servicios_por_Departamento("315 BLOCK H")
        @controlador.buscar_Servicios_por_Dni("60110760")
        @controlador.obtener_Listado_Servicios("Noviembre")

        @controlador.obtener_Listado_Visitas_fecha(28, "Noviembre")
        @controlador.obtener_Listado_Visitas_Departamento("157 BLOCK C")
        @controlador.obtener_Listado_Visitas_Dni("25723402")
        @controlador.buscar_visitas_rango_fecha(0,30)

        @controlador.buscar_Deudores_Departamento("131 BLOCK F")
        @controlador.obtener_Listado_deudores(0)
  end
end