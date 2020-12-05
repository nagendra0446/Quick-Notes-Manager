package my_pack;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

@WebServlet("/AddUserServlet")
public class AddUserServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	@Resource(name="mysql/nagdb")
	DataSource ds;
	String query;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		
		String query="";
		try 
		{
			 query = "INSERT INTO MEMBERS(first_name, last_name, email, mobile, uname, pass) VALUES("+
					 "'"+request.getParameter("first_name").replace("'", "''")+"'"+","+
					 "'"+request.getParameter("last_name").replace("'", "''")+"'"+","+
					 "'"+getFilteredParameter(request,"email").replace("'", "''")+"'"+","+
					 "'"+getFilteredParameter(request,"mobile").replace("'", "''")+"'"+","+
					 "'"+request.getParameter("uname").replace("'", "''").toLowerCase()+"'"+","+
					 "'"+request.getParameter("pass").replace("'", "''")+"'"+")";
			
			try(Connection con=ds.getConnection(); 
					Statement stmt=con.createStatement(); )
			{
				stmt.executeUpdate(query);
			}
			session.setAttribute("user_created", "true");
			response.sendRedirect("signin.jsp");
			
		}catch(Exception e) {
			session.setAttribute("user_already_exists", "true");
			response.sendRedirect("signin.jsp");
		}
		
	}
	
	String getFilteredParameter(HttpServletRequest request, String name)
	{
		String raw_value = request.getParameter(name);
		if(raw_value == null)
			return "";
		else
			return raw_value;
		
	}

}
