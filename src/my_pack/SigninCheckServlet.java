package my_pack;

import java.io.IOException;

import java.io.PrintWriter;

import java.sql.*;
import javax.annotation.Resource;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.sql.DataSource;

import org.apache.catalina.Session;

@WebServlet("/SigninCheckServlet")
public class SigninCheckServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	@Resource(name="mysql/nagdb")
	DataSource ds;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
												throws ServletException, IOException 
	{
		
		String userid = request.getParameter("uname").toLowerCase();
    	String pwd = request.getParameter("pass");
    	response.setContentType("text/html"); 
    	 
		String query="";
		try
		{ 
			query ="SELECT * FROM members WHERE uname='" + userid + "' and pass='" + pwd + "'";
			
			try (Connection con = ds.getConnection();
						Statement stmt = con.createStatement();)
			{
				try(ResultSet rs = stmt.executeQuery(query))
				{
					if (rs.next()) 
					{
						HttpSession session = request.getSession();
        				session.setAttribute("userid", userid);
        				response.sendRedirect("notes_home.jsp");					
					} 
					else 
					{
						HttpSession session = request.getSession();
						session.setAttribute("is_valid", "false");
						response.sendRedirect("signin.jsp");
    				}
				}
			}
		}catch(Exception e) {e.printStackTrace();} 
	}
}
