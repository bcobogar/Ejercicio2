//
//  ContentView.swift
//  Ejercicio2
//
//  Created by Beatriz Maria Cobo Garcia on 21/04/2026.
//

import SwiftUI
 
struct ContentView: View {
    @StateObject var viewModel = SolicitudViewModel()
 
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Datos principales")) {
                    TextField("Título (5 a 60 letras)", text: $viewModel.titulo)
                    
                    TextField("Tu correo email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }
                
                Section(header: Text("Detalles del ticket")) {
                    Text("Descripcion (20 a 500)")
                    TextEditor(text: $viewModel.descripcion).frame(height: 100)
                    
                    Picker("Categoría", selection: $viewModel.categoria) {
                        ForEach(viewModel.categoriasDisponibles, id: \.self) { opcion in
                            Text(opcion)
                        }
                    }
                    
                    Stepper("Prioridad: \(viewModel.prioridad)", value: $viewModel.prioridad, in: 1...5)
                }
                
                Section {
                    Button(action: {
                        viewModel.guardarEnNube()
                    }) {
                        if viewModel.estaEnviando{
                            Text("Enviando")
                        }else{
                            Text("Enviar solicitud")
                        }
                    }
                    .disabled(viewModel.isFormValid == false || viewModel.estaEnviando == true)
                }
                if let error = viewModel.mensajeError{
                    Section{
                        Text(error).foregroundColor(.red)
                    }
                }
                if viewModel.envioExitoso{
                    Section{
                        Text("Enviado").foregroundColor(.green)
                    }
                }
                
                // listado de solicitudes
                Section(header: Text("Mis solicitudes recientes")){
                    // si esta vacia mostramos un mensaje
                    if viewModel.listaSolicitudes.isEmpty{
                        Text("Aun no tienes registros").foregroundColor(.gray)
                    }else{
                        // recorremos la lista y pintamos los datos de cada una
                        ForEach(viewModel.listaSolicitudes, id: \.self){ Solicitud in
                            VStack(alignment: .leading){
                                Text(Solicitud.titulo)
                                Text("Prioridad: \(Solicitud.prioridad) - \(Solicitud.categoria)").font(.caption).foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("Nuevo Registro")
            .onAppear{
                viewModel.descargarMisSolicitudes()
            }
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
