package my_pack;

import java.io.IOException;
import java.sql.*;
import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import javax.sql.DataSource;

@WebServlet("/UpdateServlet")
public class UpdateServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	@Resource(name="mysql/nagdb")
	DataSource ds;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
														throws ServletException, IOException 
	{
		HttpSession session = request.getSession();
		
		if(session.getAttribute("userid") == null)
		{
			session.setAttribute("is_valid_session", "false");
			response.sendRedirect("signin.jsp");
		}
		else
		{
			String query="";
			try 
			{
				 query = "UPDATE NOTES_TAB SET "+
						"TITLE='"+request.getParameter("TITLE").replace("'", "''")+"'"+
						",NOTES='"+request.getParameter("NOTES").replace("'", "''")+"'"+
						",STATUS='"+request.getParameter("STATUS").replace("'", "''")+"'"+
						" WHERE S_NO="+request.getParameter("S_NO") + " AND USERID='"+session.getAttribute("userid")+"'";
				
				try(Connection con=ds.getConnection(); 
						Statement stmt=con.createStatement(); )
				{
					stmt.executeUpdate(query);
				}
				
				response.sendRedirect("notes_home.jsp");
				
			}catch(Exception e) {System.out.println(query);}
		}
	}
}
