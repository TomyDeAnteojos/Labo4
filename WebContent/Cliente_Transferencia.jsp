<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.util.ArrayList" %>
<%@ page import="entidad.Cuenta" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/styles.css">
<title>Transferencia</title>
</head>
<body class="cl">

	<% //revisa que el usuario sea cliente
		if(session.getAttribute("tipoUsuario") != "cliente"  )
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
			<li><a href="Cliente_Transferencia.jsp">Transferencia</a></li>
			<li><a href="Cliente_Home.jsp">Historial</a></li>
			<li><a href="ServletPrestamos">Prestamo</a></li>
			<li><a href="Cliente_Perfil.jsp">Perfil</a></li>
		</ul>
	</nav>
	
	<div class="transferencia">
		<div class="tr1">
			<p>Transferir</p>
			<form action="ServletTransferencia" method="post">
			<label for="cbu">CBU:</label>
        	<input type="text" id="cbu" name="cbuDestino" placeholder="Ingrese CBU">
        	<br><br>
        	<label for="monto1">Monto:</label>
        	<input type="number" id="monto_1" name="monto" placeholder="Ingrese el Monto">
        	<br><br>
        	<button type="submit" name="enviarMonto" value="transferirOtro" class="btn-aceptar">Aceptar</button>
        	</form>
		</div>

		<div class="tr2">
			<p>Transferir a tus cuentas</p>
			<form action="ServletTransferencia" method="post">
				


		<form action="ServletDescolgable" method="post">
				<input type="submit" name="btn_TCT" value="Traer Cuentas"> <!--  ABREVIATURA Traer Cliente Home-->
			</form>	
			
				<% 
				ArrayList<Cuenta> cuentas = null;
				if(request.getAttribute("cuentas") != null) {
					cuentas = (ArrayList<Cuenta>) request.getAttribute("cuentas");
				}
				%>
			
				<div class="filtrar_cuentas">
					Elige una cuenta: 
					<select name="cuenta" id="cuenta">
					<%
						if (cuentas != null) {
						for (Cuenta cuenta : cuentas) {
					%>
					<option value="<%= cuenta.getUsuario() %>"><%= cuenta.getUsuario() %></option>
					<%
						}
					}
					%>
				</select>

	        	<label for="monto2">Monto:</label>
	        	<input type="number" id="monto_2" placeholder="Ingrese el Monto">
	        	<br><br>
	        	<button type="submit" name="enviarMonto" value="transferir_propia" class="btn-aceptar">Aceptar</button>
        	 </form>
			
		</div>
		<div class="tr3">
			<div class="error-message">
				<%= request.getAttribute("msj_error") != null ? request.getAttribute("msj_error") : "" %>
			</div>
		</div>
	</div>

	

</body>
</html>