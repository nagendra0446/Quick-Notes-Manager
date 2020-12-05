package my_pack;

import java.io.IOException;
import java.sql.*;
import javax.annotation.Resource;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.sql.DataSource;


@WebServlet("/DeleteServlet")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Resource(name="mysql/nagdb")
	DataSource ds;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		
		if(session.getAttribute("userid") == null)
		{
			session.setAttribute("is_valid_session", "false");
			response.sendRedirect("signin.jsp");
		}
		String query="";
		try 
		{
			  query = "DELETE FROM NOTES_TAB WHERE S_NO="+getFilteredParameter(request, "S_NO") + " AND USERID='"+session.getAttribute("userid")+"'";
			
			try(Connection con=ds.getConnection(); 
					Statement stmt=con.createStatement(); )
			{
				stmt.executeUpdate(query);
			}
			
			response.sendRedirect("notes_home.jsp");
			
		}catch(Exception e) {System.out.println(e);}

	}
	
	String getFilteredParameter(HttpServletRequest request, String name)
	{
		String raw_value = request.getParameter(name);
		if(raw_value == null)
			return "NULL";
		else
			return raw_value;
	}
}
