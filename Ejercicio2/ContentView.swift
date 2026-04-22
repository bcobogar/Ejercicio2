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
                }
                
                Section(header: Text("Detalles del ticket")) {
                    TextField("Descripción (20 a 500 letras):", text: $viewModel.descripcion)
                    
                    Picker("Categoría", selection: $viewModel.categoria) {
                        ForEach(viewModel.categoriasDisponibles, id: \.self) { opcion in
                            Text(opcion)
                        }
                    }
                    
                    Stepper("Prioridad: \(viewModel.prioridad)", value: $viewModel.prioridad, in: 1...5)
                }
                
                Section {
                    Button(action: {
                        print("Pulsado el botón de enviar")
                    }) {
                        Text("Enviar solicitud")
                            .bold()
                    }
                    .disabled(viewModel.isFormValid == false)
                }
            }
            .navigationTitle("Nuevo Registro")
        }
    }
}
 
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
