<%@ page contentType="text/html; charset=UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Incidència - Vigilante Tarragona</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/resources/css/style.css"/>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css"/>
</head>
<body>
    <jsp:include page="/WEB-INF/jspf/header.jsp" />
    <div class="container">
        <div class="incident-form-container">
            <h1 class="form-title"><i class="fas fa-edit"></i> Editar Incidencia</h1>
            <%
                model.entities.IncidentDTO incident = (model.entities.IncidentDTO) request.getAttribute("incident");
            %>
            <form id="incidentForm" method="post" action="<%= request.getContextPath() %>/IncidentController?action=update" class="incident-form">
                <input type="hidden" name="id" value="<%= incident.getId() %>">
                <div class="form-group">
                    <label for="title"><i class="fas fa-heading"></i> Título</label>
                    <input type="text" id="title" name="title" value="<%= incident.getTitle() %>" required>
                </div>
                <div class="form-group">
                    <label for="description"><i class="fas fa-align-left"></i> Descripción</label>
                    <textarea id="description" name="description" rows="10" required><%= incident.getDescription() %></textarea>
                </div>
                <div class="form-group">
                    <label for="imageUrl"><i class="fas fa-image"></i> URL de la Imagen</label>
                    <input type="text" id="imageUrl" name="imageUrl" value="<%= incident.getImageUrl() %>" required>
                </div>
                <div class="form-group">
                    <label for="latitude"><i class="fas fa-map-marker-alt"></i> Latitud</label>
                    <input type="text" id="latitude" name="latitude" value="<%= incident.getLatitude() %>" required>
                </div>
                <div class="form-group">
                    <label for="longitude"><i class="fas fa-map-marker-alt"></i> Longitud</label>
                    <input type="text" id="longitude" name="longitude" value="<%= incident.getLongitude() %>" required>
                </div>
                <div class="form-actions">
                    <button type="submit" class="btn-primary" id="submitButton">
                        <i class="fas fa-save"></i> Guardar Cambios
                    </button>
                    <a href="<%= request.getContextPath() %>/IncidentController?action=detail&id=<%= incident.getId() %>" class="btn-secondary">
                        <i class="fas fa-times"></i> Cancelar
                    </a>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
