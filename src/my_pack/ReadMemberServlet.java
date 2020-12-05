package my_pack;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

@WebServlet("/ReadMemberServlet")
public class ReadMemberServlet extends HttpServlet {
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
				query ="SELECT FIRST_NAME,LAST_NAME,EMAIL,MOBILE,UNAME,PASS "
						+ "FROM MEMBERS WHERE UNAME='"+ session.getAttribute("userid") +"'";
				
				try (Connection con = ds.getConnection();
							Statement stmt = con.createStatement();)
				{
					List<Object> member_result;
					try(ResultSet rs = stmt.executeQuery(query))
					{
						member_result = toList(rs);
					}
					
					
					session.setAttribute("member_result", member_result);
					
					String jsp_name = (String)request.getAttribute("jsp_name");
					response.sendRedirect(jsp_name);
				}
				
			}catch(Exception e) {e.printStackTrace();} 
		}
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
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
				query ="SELECT FIRST_NAME,LAST_NAME,EMAIL,MOBILE,UNAME,PASS "
						+ "FROM MEMBERS WHERE UNAME='"+ session.getAttribute("userid") +"'";
		
				try (Connection con = ds.getConnection();
						Statement stmt = con.createStatement();)
				{
					List<Object> member_result;
					try(ResultSet rs = stmt.executeQuery(query))
					{
						member_result = toList(rs);
					}
			
					session.setAttribute("member_result", member_result);
			
					String jsp_name = (String)request.getAttribute("jsp_name");
					response.sendRedirect(jsp_name);
				}
			}catch(Exception e) {e.printStackTrace();} 
		}
	}
	
	List<Object> toList(ResultSet rs)
	{
		List<Object> member_result = new ArrayList<>();
		try 
		{
			ResultSetMetaData rsmd = rs.getMetaData();
			
	    	int column_count = rsmd.getColumnCount();
	    	
	    	while(rs.next())
	    	{	
	    		for(int i=1; i<=column_count; i++)
	    		{
	    			Object o = rs.getObject(i);
	    			if(o == null)
	    				member_result.add("");
	    			else
	    				member_result.add(o);
	    		}
	    	}
		}catch(Exception e) {}
		return member_result;
	}
}
