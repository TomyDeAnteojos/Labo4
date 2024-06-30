<%@ page import="entidad.Prestamo"%>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/styles.css">
<title>Insert title here</title>
</head>
<body class="cl">

	<% //revisa que el usuario sea Admin
		if(session.getAttribute("tipoUsuario") != "administrador"  )
		{
			RequestDispatcher rd = null;
			rd = request.getRequestDispatcher("/Login.jsp");
			rd.forward(request, response);
		}
	%>

	<nav class="mask">
		<div class="name-user">
			<%= session.getAttribute("nm_user") != null ? session.getAttribute("nm_user") : "" %>
		</div>
		<ul class="list">
			<li><a href="Admin_Perfiles.jsp">Perfiles</a></li>
			<li><a href="Admin_Prestamos.jsp">Prestamos</a></li>
			<li><a href="Admin_Estadisticas.jsp">estadisticas</a></li>
			<li><a href="Admin_Cuentas.jsp">Cuentas</a></li>
		</ul>
	</nav>
	<form action="ServletPrestamos" method="Post">
	<div class="filtros-prestamos">
		Capital Min.:
		<input type="number" name="capMin">
		<br><br>
		Capital Max.:
		<input type="number" name="capMax">
		<br><br>
		<div class="btn-filtrar-prestamos">
			<input type="submit" value="aceptar" name="aceptar-f">
			<input type="submit" value="remover" name="remover-f">
		</div>
		<br><br>
	</div>
	</form>
	
	<% 
	// Par�metros de paginaci�n
    int pageSize = 10; // N�mero de elementos por p�gina
    int pageNumber = 1; // N�mero de la p�gina actual
    if (request.getParameter("page") != null) {
        pageNumber = Integer.parseInt(request.getParameter("page"));
    }

    
    
    ArrayList<Prestamo> listaPrestamos = null;
	if(request.getAttribute("listaTPrestamos") != null) {
    listaPrestamos = (ArrayList<Prestamo>) request.getAttribute("listaTPrestamos");
	} 
    
    // C�lculo de la paginaci�n
    //int totalItems = movimientos.size();
    //int totalPages = (int) Math.ceil((double) totalItems / pageSize);
    //int startIndex = (pageNumber - 1) * pageSize;
    //int endIndex = Math.min(startIndex + pageSize, totalItems);    
	%>
	
	<form action="ServletPrestamos" method="post">
	<input type="submit" name="btn_traerPrestamos" value="Traer Prestamos Pendientes">
	</form>	
	
	<table>
    <tr>
        <th>Id Cuenta</th>
        <th>Capital</th>
        <th>Meses</th>
        <th>Valor Cuota</th>
        <th>Aceptar</th>
        <th>Rechazar</th>
    </tr>
    <!--  for (MovimientoXTransferencia movimiento : pageItems) {   -->
    <tbody>
    <% if(listaPrestamos != null) {
        for(Prestamo prestamo : listaPrestamos) { %>
    <tr>
    	<form action="ServletPrestamos" method="post">
        	<td> <%=prestamo.getIdCuenta() %><input type="hidden" name="idCuenta" value="<%=prestamo.getIdCuenta() %>">	</td>
        	<td> <%=prestamo.getMontoTotal() %></td>
        	<td> <%=prestamo.getCantMeses() %></td>
       		<td> <%=prestamo.getMontoMensual() %></td>
        	<td> <input type="submit" name="aceptar" value="aceptar"></td>
        	<td> <input type="submit" name="rechazar" value="rechazar"></td>
    	</form>
    </tr>
            <% }
    } %>
    <!-- } --> 
    </tbody>
	</table>
	
	<div class="error-message">
		<%= request.getAttribute("msj_error") != null ? request.getAttribute("msj_error") : "" %>
	</div>
	
</body>
</html>