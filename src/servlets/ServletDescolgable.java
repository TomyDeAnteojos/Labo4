package servlets;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import entidad.Cuenta;
import entidad.Localidad;
import entidad.Pais;
import entidad.Provincia;
import negocio.CuentaNegocio;
import negocio.LocalidadNegocio;
import negocio.PaisNegocio;
import negocio.ProvinciaNegocio;
import negocio.TipoCuentaNegocio;
import negocioImpl.CuentaNegocioImpl;
import negocioImpl.LocalidadNegocioImpl;
import negocioImpl.PaisNegocioImpl;
import negocioImpl.ProvinciaNegocioImpl;
import negocioImpl.TipoCuentaNegocioImpl;


@WebServlet("/ServletDescolgable")
public class ServletDescolgable extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	ProvinciaNegocio proNeg = new ProvinciaNegocioImpl();
	LocalidadNegocio loNeg = new LocalidadNegocioImpl();
    
    public ServletDescolgable() {
        super();
        // TODO Auto-generated constructor stub
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		traerPaises(request);
        request.getRequestDispatcher("/Admin_Perfiles.jsp").forward(request, response);
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		RequestDispatcher rd = null;
		
		String accion = request.getParameter("accion");
		if (accion != null) {
			if(accion.equals("cargarProvincias")) {
				int paisId = Integer.parseInt(request.getParameter("paisId"));
				List<Provincia> provincias = proNeg.obtenerProvinciasPorPais(paisId);
				request.getSession().setAttribute("provincias", provincias);
				rd = request.getRequestDispatcher("/Admin_Perfiles.jsp");
				rd.forward(request, response);
				return;
			} else if(accion.equals("cargarLocalidades")) {
				int provinciaId = Integer.parseInt(request.getParameter("provinciaId"));
				List<Localidad> localidades = loNeg.obtenerLocalidadesPorProvincia(provinciaId);
				request.getSession().setAttribute("localidades", localidades);
				rd = request.getRequestDispatcher("/Admin_Perfiles.jsp");
				rd.forward(request, response);
				return;
			}
		}
		
		if(request.getParameter("btn_traerPaises") != null)
		{
			traerPaises(request);
		    rd = request.getRequestDispatcher("/Admin_Perfiles.jsp");
		    rd.forward(request, response);
		    return;
		}
		if(request.getParameter("btn_TCH") != null)
		{
			traerCuentas(request);
		    rd = request.getRequestDispatcher("/Cliente_Home.jsp");
		    rd.forward(request, response);
		    return;
		}
		if(request.getParameter("btn_TCPe") != null)
		{
			traerCuentas(request);
		    rd = request.getRequestDispatcher("/Cliente_Perfil.jsp");
		    rd.forward(request, response);
		    return;
		}
		if(request.getParameter("btn_TCPr") != null)
		{
			traerCuentas(request);
		    rd = request.getRequestDispatcher("/Cliente_Prestamo.jsp");
		    rd.forward(request, response);
		    return;
		}
		if(request.getParameter("btn_TCT") != null)
		{
			traerCuentas(request);
		    rd = request.getRequestDispatcher("/Cliente_Transferencia.jsp");
		    rd.forward(request, response);
		    return;
		}
		if(request.getParameter("btn_TCT2") != null)
		{
			traerCuentas(request);
		    rd = request.getRequestDispatcher("/Cliente_Transferencia.jsp");
		    rd.forward(request, response);
		    return;
		}
		if(request.getParameter("btn_traerTipos") != null)
		{
			traerTipos(request);
		    rd = request.getRequestDispatcher("/Admin_Cuentas.jsp");
		    rd.forward(request, response);
		    return;
		}
		
		
		
	}

	private void traerTipos(HttpServletRequest request) {
		TipoCuentaNegocio tNeg = new TipoCuentaNegocioImpl();
		ArrayList<String> tipos = tNeg.traerTipo();
		request.setAttribute("tipos", tipos);
	}


	public void traerPaises(HttpServletRequest request)
	{
		PaisNegocio paisNeg = new PaisNegocioImpl();
        ArrayList<Pais> paises = paisNeg.traerPaises();
        request.setAttribute("paises", paises);
	}
	
	public void traerCuentas(HttpServletRequest request)
	{
		CuentaNegocio cuNeg = new CuentaNegocioImpl();
		HttpSession session = request.getSession();
		int dni = (int)session.getAttribute("dni");
		ArrayList<Cuenta> cuentas = cuNeg.obtenerTodasLasCuentas(dni);
        request.setAttribute("cuentas", cuentas);
	}
}
