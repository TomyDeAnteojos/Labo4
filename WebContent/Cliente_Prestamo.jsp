<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="entidad.Cliente"%>
<%@ page import="entidad.Cuenta"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" type="text/css" href="CSS/styles.css">
<title>Prestamo</title>
</head>
<body class="cl">

	<%
		Cliente cli = null;
	
		if (session.getAttribute("usuarioLogueado") != null)
			cli = (Cliente) session.getAttribute("usuarioLogueado");
	
	%>

	<nav class="mask">
		
		<%= cli.getApellido() + ", " + cli.getNombre() %>
		<ul class="list">
			<li><a href="Cliente_Transferencia.jsp">Transferencia</a></li>
			<li><a href="Cliente_Home.jsp">Historial</a></li>
			<li><a href="prestamos">Prestamo</a></li>
			<li><a href="Cliente_Perfil.jsp">Perfil</a></li>
		</ul>
	</nav>
	<div class="prestamo">
		<div class="pedir_prestamo">

			
			<form action="ServletPrestamos" method="post" class="nuevo-prestamo">
			
				<div class="inputs">
					<label for="capital">Capital:</label>
					<input type="number" id="capital" placeholder="Ingrese el capital" min="100" step="100.00" required autofocus="autofocus">			
					<label for="meses">Meses:</label>
					<input type="number" id="meses" placeholder="Ingrese meses" min="1" step="1" required value="12" >				
				</div>
	

			<div class="filtrar_cuentas">
					<label>Elige una cuenta:</label>
					<select name="cuenta" id="cuenta">
						<% for (Cuenta cta : cli.cuentas()) {%>
							<option value="<%= cta.getId() %>"><%= cta.getTipo() + " [" + cta.getCBU() + "]"   %></option>	
						<%} %>
					</select>
				</div>                 
				
				<div class="montos">
					<div class="monto-mensual">
						<span>Monto Mensual:</span>
						<span id="total-mensual"></span>
					</div>
					<div class="monto-total">
						<span>Monto Total:</span>
						<span id="total"></span>
					</div>				
				</div>
				
				<input type="submit" class="btn-aceptar btn-solicitar-prestamo" value="SOLICITAR">
			
			</form>
			

			<div class="error-message">
				<%= request.getAttribute("msj_error") != null ? request.getAttribute("msj_error") : "" %>
			</div>
		</div>


		<div class="lista_prestamo">


			<%
    // Simulamos datos de movimientos para este ejemplo
    List<String[]> movimientos = new ArrayList<String[]>();
    for (int i = 1; i <= 50; i++) {
        movimientos.add(new String[]{ "" + i, "$" + (i*69.69 + 1), ""});
    }

    // Par�metros de paginaci�n
    int pageSize = 10; // N�mero de elementos por p�gina
    int pageNumber = 1; // N�mero de la p�gina actual
    if (request.getParameter("page") != null) {
        pageNumber = Integer.parseInt(request.getParameter("page"));
    }

    // C�lculo de la paginaci�n
    int totalItems = movimientos.size();
    int totalPages = (int) Math.ceil((double) totalItems / pageSize);
    int startIndex = (pageNumber - 1) * pageSize;
    int endIndex = Math.min(startIndex + pageSize, totalItems);

    // Sublista para la p�gina actual
    List<String[]> pageItems = movimientos.subList(startIndex, endIndex);
%>


			<table>
				<tr>
					<th>Cuota Nro.</th>
					<th>Monto</th>
					<th>Pagar</th>
				</tr>
				<% for (String[] movimiento : pageItems) { %>
				<tr>
					<td><%= movimiento[0] %></td>
					<td><%= movimiento[1] %></td>
					<td>
						<button>Ir a Pagar</button>
					</td>
				</tr>
				<% } %>
			</table>

			<div class="pagination">
				<% for (int i = 1; i <= totalPages; i++) { %>
				<a href="?page=<%= i %>"
					class="<%= (i == pageNumber) ? "active" : "" %>"><%= i %></a>
				<% } %>
			</div>

		</div>
	</div>

	<script>
	document.addEventListener('DOMContentLoaded', function() {
		
		const input_capital = document.getElementById('capital');
		const input_meses = document.getElementById('meses');
		const total = document.getElementById('total');
		const total_mensual = document.getElementById('total-mensual');
		const INTERES_ANUAL = 0.75; // 75%
		
		function actualizarMontos() {
			
		    const monto = parseFloat(input_capital.value) || 0;
		    const meses = parseFloat(input_meses.value) || 0;
		
		    const FACTOR_INTERES_MENSUAL = (1 + (INTERES_ANUAL / 12) * meses);
		    const total_final = monto * FACTOR_INTERES_MENSUAL;
		    const mensual = total_final / meses;
		
		    total.textContent = total_final.toFixed(2);
		    total_mensual.textContent = mensual.toFixed(2);
		}
		
		input_capital.addEventListener('input', actualizarMontos);
		input_meses.addEventListener('input', actualizarMontos);
		
	});
	</script>

</body>
</html>