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

## Configuración
1. Ve al archivo `SolicitudViewModel.swift`.
2. Sustituye `Proyecto` y `apikey` por `https://wadnittjqhpcpgypwgzs.supabase.co` y `eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6IndhZG5pdHRqcWhwY3BneXB3Z3pzIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzY3NTQwMDYsImV4cCI6MjA5MjMzMDAwNn0.h7khwI5XROfX-X7jXSkJi2eSQaQ-lUnXpmms61yxXqk

## Enlace al video
https://drive.google.com/file/d/1om0ArbVnI36g__bpuaNsb_IAvC11QTfQ/view?usp=sharing
