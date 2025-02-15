<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Incidencias y Sugerencias</title>
  <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/style.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">
  <style>
    /* Panel compacto similar a la nueva incidencia */
    .admin-panel {
      max-width: 600px;
      margin: 40px auto;
      background: #fff;
      padding: 20px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      overflow: hidden;
    }
    /* Encabezado interno (pestañas) */
    .tab-header {
      display: flex;
      border-bottom: 1px solid #ddd;
      background-color: #f7f7f7;
    }
    .tab-header .tab-button {
      flex: 1;
      padding: 12px 0;
      background: transparent;
      border: none;
      border-right: 1px solid #ddd;
      font-size: 0.95rem;
      color: #555;
      cursor: pointer;
      transition: background-color 0.3s, color 0.3s;
    }
    .tab-header .tab-button:last-child {
      border-right: none;
    }
    .tab-header .tab-button.active,
    .tab-header .tab-button:hover {
      background-color: #e0e0e0;
      color: #333;
    }
    /* Contenido de cada pestaña */
    .tab-content {
      padding: 20px 10px;
    }
    /* Filtros de incidencias */
    .form-group {
      margin: 20px 0;
    }
    .topics-container {
      display: flex;
      flex-wrap: wrap;
      gap: 8px;
      margin-top: 10px;
    }
    .topic-chip {
      display: inline-flex;
      align-items: center;
      background-color: #ececec;
      padding: 4px 10px;
      border-radius: 16px;
      font-size: 0.85rem;
      color: #555;
      cursor: pointer;
      transition: background-color 0.3s;
    }
    .topic-chip:hover {
      background-color: #d8d8d8;
    }
    .topic-chip input {
      margin-right: 5px;
    }
    /* Tablas */
    table {
      width: 100%;
      border-collapse: collapse;
      margin: 20px 0;
    }
    table thead {
      background-color: #e0e0e0;
      color: #333;
    }
    table th,
    table td {
      padding: 10px;
      border: 1px solid #ddd;
      text-align: left;
    }
    table tbody tr:nth-child(even) {
      background-color: #f9f9f9;
    }
    /* Paginación */
    .paginacion {
      display: flex;
      justify-content: center;
      margin: 20px 0;
    }
    .pagination {
      display: inline-flex;
      list-style: none;
      padding: 0;
      margin: 0;
    }
    .pagination li {
      margin: 0 5px;
    }
    .pagination li a {
      display: block;
      padding: 6px 10px;
      background-color: #f5f5f5;
      color: #555;
      border: 1px solid #ccc;
      border-radius: 4px;
      text-decoration: none;
      transition: background-color 0.3s, color 0.3s;
    }
    .pagination li a:hover {
      background-color: #ddd;
      color: #333;
    }
    .pagination li a.active {
      background-color: #ccc;
      color: #333;
      border-color: #bbb;
    }
  </style>
  <script>
    function showTab(tab) {
      // Oculta ambas secciones
      document.getElementById('incidencias').style.display = 'none';
      document.getElementById('sugerencias').style.display = 'none';
      
      // Quita la clase activa de ambos botones
      document.getElementById('incidenciasButton').classList.remove('active');
      document.getElementById('sugerenciasButton').classList.remove('active');
      
      // Muestra la pestaña seleccionada y marca el botón activo
      document.getElementById(tab).style.display = 'block';
      document.getElementById(tab + 'Button').classList.add('active');
    }
    window.onload = function() {
      showTab('incidencias'); // Por defecto se muestra Incidencias
    };
  </script>
</head>
<body>
  <jsp:include page="/WEB-INF/jspf/header.jsp" />
  <div class="admin-panel">
    <!-- Encabezado interno con pestañas -->
    <div class="tab-header">
      <button id="incidenciasButton" class="tab-button active" onclick="showTab('incidencias')">
        <i class="fas fa-exclamation-circle"></i> Incidencias
      </button>
      <button id="sugerenciasButton" class="tab-button" onclick="showTab('sugerencias')">
        <i class="fas fa-comment-alt"></i> Sugerencias
      </button>
    </div>
    
    <!-- Contenido de Incidencias (con filtros y tabla) -->
    <div id="incidencias" class="tab-content">
      <h2>Listado de Incidencias</h2>
      <div class="form-group">
        <label><i class="fas fa-tags"></i> Filtrar por categoría:</label>
        <div class="topics-container">
          <c:forEach var="categoria" items="${categorias}">
            <label class="topic-chip">
              <input type="checkbox" name="categorias" value="${categoria}">
              <span>${categoria}</span>
            </label>
          </c:forEach>
        </div>
      </div>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Descripción</th>
            <th>Categoría</th>
            <th>Estado</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="incidencia" items="${incidencias}">
            <tr>
              <td>${incidencia.id}</td>
              <td>${incidencia.descripcion}</td>
              <td>${incidencia.categoria}</td>
              <td>${incidencia.estado}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <div id="incidenciasPaginacion" class="paginacion">
        <ul class="pagination">
          <li><a href="#">&laquo;</a></li>
          <li><a href="#" class="active">1</a></li>
          <li><a href="#">2</a></li>
          <li><a href="#">3</a></li>
          <li><a href="#">&raquo;</a></li>
        </ul>
      </div>
    </div>
    
    <!-- Contenido de Sugerencias -->
    <div id="sugerencias" class="tab-content" style="display: none;">
      <h2>Listado de Sugerencias</h2>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Descripción</th>
          </tr>
        </thead>
        <tbody>
          <c:forEach var="sugerencia" items="${sugerencias}">
            <tr>
              <td>${sugerencia.id}</td>
              <td>${sugerencia.descripcion}</td>
            </tr>
          </c:forEach>
        </tbody>
      </table>
      <div id="sugerenciasPaginacion" class="paginacion">
        <ul class="pagination">
          <li><a href="#">&laquo;</a></li>
          <li><a href="#" class="active">1</a></li>
          <li><a href="#">2</a></li>
          <li><a href="#">3</a></li>
          <li><a href="#">&raquo;</a></li>
        </ul>
      </div>
    </div>
  </div>
</body>
</html>
