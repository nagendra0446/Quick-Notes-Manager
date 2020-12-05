package my_pack;

import java.io.IOException;
import java.sql.*;
import javax.annotation.Resource;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.sql.DataSource;

@WebServlet("/AddServlet")
public class AddServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	@Resource(name="mysql/nagdb")
	DataSource ds;
	String query;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		
		if(session.getAttribute("userid") == null)
		{
			session.setAttribute("is_valid_session", "false");
			response.sendRedirect("signin.jsp");
		}
		else
		{
			try 
			{
				query="INSERT INTO NOTES_TAB(TITLE,NOTES,STATUS,USERID)"
						+" VALUES("+
						"'"+request.getParameter("TITLE").replace("'", "''")+"'"+","+
						"'"+request.getParameter("NOTES").replace("'", "''")+"'"+","+
						"'"+request.getParameter("STATUS").replace("'", "''")+"'"+","+
						"'"+session.getAttribute("userid").toString().replace("'", "''")+"'"+")";
				
				try(Connection con=ds.getConnection(); 
						Statement stmt=con.createStatement(); )
				{
					stmt.executeUpdate(query);
				}
				
				response.sendRedirect("notes_home.jsp");
				
			}catch(Exception e) {System.out.println(e +" The query is : "+query);}
		}
	}
}
