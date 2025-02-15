<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <title>Nueva Incidencia</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    .new-incident-container {
      max-width: 600px;
      margin: 40px auto;
      background: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
    .new-incident-container h1 {
      text-align: center;
      margin-bottom: 20px;
      color: #007aff;
    }
    .new-incident-container form {
      display: flex;
      flex-direction: column;
      gap: 15px;
    }
    .new-incident-container label {
      font-weight: bold;
      margin-bottom: 5px;
      display: block;
      color: #333;
    }
    .new-incident-container input[type="text"],
    .new-incident-container textarea,
    .new-incident-container input[type="file"] {
      width: 100%;
      padding: 10px;
      border: 1px solid #ddd;
      border-radius: 5px;
      font-size: 1rem;
    }
    .new-incident-container button {
      padding: 10px;
      background-color: #007aff;
      color: #fff;
      border: none;
      border-radius: 5px;
      font-size: 1.1rem;
      cursor: pointer;
      transition: background-color 0.3s ease, transform 0.3s ease;
    }
    .new-incident-container button:hover {
      background-color: #005bb5;
      transform: scale(1.05);
    }
    #geoMessage {
      font-style: italic;
      color: #555;
      margin-top: 5px;
    }
    .geo-btn {
      margin-top: 5px;
      padding: 8px 12px;
      background-color: #34c759;
      color: #fff;
      border: none;
      border-radius: 5px;
      cursor: pointer;
      font-size: 0.9rem;
      transition: background-color 0.3s ease;
    }
    .geo-btn:hover {
      background-color: #2fa44f;
    }
  </style>
  <script>
    // Función para geocodificación inversa: obtener la dirección a partir de lat, lon
    function reverseGeocode(lat, lon) {
      const url = "https://nominatim.openstreetmap.org/reverse?format=json&lat=" 
                + lat + "&lon=" + lon;
      fetch(url)
        .then(response => response.json())
        .then(data => {
          if (data && data.display_name) {
            document.getElementById('street').value = data.display_name;
            document.getElementById('geoMessage').textContent = "Dirección autocompletada.";
          } else {
            document.getElementById('geoMessage').textContent = "No se encontró la dirección.";
          }
        })
        .catch(error => {
          console.error("Error en geocodificación inversa:", error);
          document.getElementById('geoMessage').textContent = "Error al obtener la dirección.";
        });
    }

    // Función para geocodificar manualmente la dirección ingresada
    function geocodeAddress() {
      const street = document.getElementById('street').value;
      if (street.trim() === "") return;
      const url = "https://nominatim.openstreetmap.org/search?format=json&q=" 
                + encodeURIComponent(street + ", Tarragona, España");
      fetch(url)
        .then(response => response.json())
        .then(data => {
          if (data && data.length > 0) {
            document.getElementById('latitude').value = data[0].lat;
            document.getElementById('longitude').value = data[0].lon;
            document.getElementById('geoMessage').textContent = "Ubicación encontrada: " + data[0].display_name;
          } else {
            document.getElementById('geoMessage').textContent = "No se encontró la ubicación.";
          }
        })
        .catch(error => {
          console.error("Error al geocodificar:", error);
          document.getElementById('geoMessage').textContent = "Error al buscar la ubicación.";
        });
    }

    // Al cargar la página, si hay parámetros lat y lon, se rellenan y se ejecuta la geocodificación inversa
    window.onload = function() {
      const urlParams = new URLSearchParams(window.location.search);
      const lat = urlParams.get('lat');
      const lon = urlParams.get('lon');
      if (lat && lon) {
          document.getElementById('latitude').value = lat;
          document.getElementById('longitude').value = lon;
          reverseGeocode(lat, lon);
      }
    }
  </script>
</head>
<body>
  <jsp:include page="/WEB-INF/jspf/header.jsp" />
  <div class="new-incident-container">
    <h1>Nueva Incidencia</h1>
    <form method="post" action="<%= request.getContextPath() %>/IncidentController?action=create" enctype="multipart/form-data">
      <!-- Campo para ingresar la dirección -->
      <div class="form-group">
        <label for="street"><i class="fas fa-map-marker-alt"></i> Calle en Tarragona</label>
        <input type="text" id="street" name="street" placeholder="Ingresa la calle (ej. Calle Mayor)" required>
        <button type="button" class="geo-btn" onclick="geocodeAddress()">Buscar Ubicación</button>
        <div id="geoMessage"></div>
      </div>
      <!-- Campos ocultos para latitud y longitud -->
      <input type="hidden" id="latitude" name="latitude">
      <input type="hidden" id="longitude" name="longitude">
      
      <!-- Campo para la descripción de la incidencia -->
      <div class="form-group">
        <label for="description"><i class="fas fa-align-left"></i> Resumen de la incidencia</label>
        <textarea id="description" name="description" placeholder="Describe la incidencia" required></textarea>
      </div>
      <!-- Campo para la fotografía de la incidencia -->
      <div class="form-group">
        <label for="image"><i class="fas fa-image"></i> Fotografía de la incidencia</label>
        <input type="file" id="image" name="image" accept="image/*" required>
      </div>
      <button type="submit">Enviar Incidencia</button>
    </form>
  </div>
</body>
</html>
