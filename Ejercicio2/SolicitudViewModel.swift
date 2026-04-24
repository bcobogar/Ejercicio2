import SwiftUI
import Combine
import Supabase
 
// modelo
struct Solicitud: Codable, Identifiable, Hashable {
    var id: Int?
    var titulo: String
    var descripcion: String
    var categoria: String
    var prioridad: Int
    var email: String
}
 
// viewmodel
class SolicitudViewModel: ObservableObject {
    
    // Los datos
    @Published var titulo: String = ""
    @Published var descripcion: String = ""
    @Published var categoria: String = "Soporte"
    @Published var prioridad: Int = 3
    @Published var email: String = ""
    
    // Estados
    @Published var estaEnviando: Bool = false
    @Published var mensajeError: String? = nil
    @Published var envioExitoso: Bool = false
    
    // Lista para guardar lo que bajamos de la base de datos
    @Published var listaSolicitudes: [Solicitud] = []
    
    // Opciones del selector
    let categoriasDisponibles = ["Soporte", "Sugerencia", "Queja", "Otros"]
    
    // Validacion
    var isFormValid: Bool {
        let tituloValido = titulo.count >= 5 && titulo.count <= 60
        let descValida = descripcion.count >= 20 && descripcion.count <= 500
        let prioridadValida = prioridad >= 1 && prioridad <= 5
        let emailValido = validarEmail(email)
        
        return tituloValido && descValida && prioridadValida && emailValido
    }
    
    // Comprobar email
    private func validarEmail(_ email: String) -> Bool {
        let emailFormato = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicado = NSPredicate(format:"SELF MATCHES %@", emailFormato)
        return emailPredicado.evaluate(with: email)
    }
    
    // Puente de conexion
    let clienteSupabase = SupabaseClient(
        supabaseURL: URL(string: "https://wadnittjqhpcpgypwgzs.supabase.co")!,
        supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndhZG5pdHRqcWhwY3BneXB3Z3pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY3NTQwMDYsImV4cCI6MjA5MjMzMDAwNn0.h7khwI5XROfX-X7jXSkJi2eSQaQ-lUnXpmms61yxXqk")
    
    // Funcion para guardar los datos a supabase
    func guardarEnNube(){
        //bloqueamos boton y limpiamos errores
        estaEnviando = true
        mensajeError = nil
        
        // preparamos el paquete de datos
        let nuevaSolicitud = Solicitud(titulo: titulo, descripcion: descripcion, categoria: categoria, prioridad: prioridad, email: email)
        
        // enviamos a la nube
        Task{
            do{
                try await clienteSupabase.from("Solicitud").insert(nuevaSolicitud).execute()
                await MainActor.run{
                    self.estaEnviando = false
                    self.envioExitoso = true
                    
                    self.descargarMisSolicitudes()
                    
                    // borramos los textos para dejar el formulario limpio
                    self.titulo = ""
                    self.descripcion = ""
                    self.email = ""
                }
            }catch{
                await MainActor.run{
                    self.estaEnviando = false
                    self.mensajeError = "No hay conexion a internet"
                }
            }
        }
    }
    
    // Funcion para descargar la lista
    func descargarMisSolicitudes(){
        Task{
            do{
                // pedimos los datos y ordenamos por fecha descendente
                let datos: [Solicitud] = try await clienteSupabase
                    .from("Solicitud")
                    .select()
                    .order("created_at", ascending: false)
                    .execute()
                    .value
                await MainActor.run{
                    // Guardamos los datos para que la pantalla los pinte
                    self.listaSolicitudes = datos
                }
            }catch{
                print("Error al descargar: \(error)")
            }
        }
    }
    
}
