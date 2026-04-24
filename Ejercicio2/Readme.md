# Ejercicio 2 - App de solicitudes

Una aplicación sencilla para iOS que permite enviar y gestionar tickets de soporte, conectada a una base de datos en la nube.

## Que hace la app
* **Formulario** Comprueba que el título, descripción y email estén bien escritos antes de dejarte enviar.
* **Guardado en la nube** Utiliza Supabase para guardar los registros de forma segura.
* **Historial integrado** Muestra una lista con las solicitudes recientes que has enviado, ordenadas por fecha.
* **Estados visuales** El botón se bloquea mientras dice "Enviando..." y te avisa con mensajes de colores y si todo esta bien o si falla el internet.

## Tecnologías utilizadas
* **SwiftUI** Para contruir toda la interfaz y las pantallas.
* **MVVM** Arquitectura del proyecto (Modelo-Vista-ViewModel).
* **Supabase** Plataforma de base de datos.

