package my_pack;

import java.io.IOException;
import java.time.*;
import java.time.format.*;

import java.sql.*;
import java.util.*;
import javax.annotation.Resource;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import javax.sql.DataSource;

@WebServlet("/ReadAllServlet")
public class ReadAllServlet extends HttpServlet 
{
	private static final long serialVersionUID = 1L;
	
	@Resource(name="mysql/nagdb")
	DataSource ds;

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
				query ="SELECT S_NO,TITLE,NOTES,STATUS,ENTRY_DT,REMARKS "
						+ "FROM NOTES_TAB  WHERE USERID='"+ session.getAttribute("userid") +"' ORDER BY S_NO DESC";
				
				try (Connection con = ds.getConnection();
							Statement stmt = con.createStatement();)
				{
					List<List<Object>> table_result;
					try(ResultSet rs = stmt.executeQuery(query))
					{
						table_result = toList(rs);
					}
					
					
					session.setAttribute("table_result", table_result);
					
					String jsp_name = (String)request.getAttribute("jsp_name");
					response.sendRedirect(jsp_name);
				}
				
			}catch(Exception e) {e.printStackTrace();} 
		}
	}
	
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
			String query;
			try
			{ 
				query ="SELECT S_NO,TITLE,NOTES,STATUS,ENTRY_DT,REMARKS "
						+ "FROM NOTES_TAB  WHERE USERID='"+ session.getAttribute("userid") +"' ORDER BY S_NO";
				
				try (Connection con = ds.getConnection();
						Statement stmt = con.createStatement();)
				{
					List<List<Object>> table_result;
					try(ResultSet rs = stmt.executeQuery(query))
					{
						table_result = toList(rs);
					}
		
					request.setAttribute("table_result", table_result);
		
					String jsp_name = (String)request.getAttribute("jsp_name");
					RequestDispatcher rd =  request.getRequestDispatcher(jsp_name);
					rd.forward(request, response);
				}
				
			}catch(Exception e){e.printStackTrace();}
		}
	}
	
	
	List<List<Object>> toList(ResultSet rs)
	{
		List<List<Object>> table_result = new ArrayList<>();
		try 
		{
			ResultSetMetaData rsmd = rs.getMetaData();
			
	    	int column_count = rsmd.getColumnCount();
	    		 
	    	
	    	List<Object> header = new ArrayList<>();
	    	
	    	for(int i=1; i<=column_count; i++)
	    		header.add(rsmd.getColumnName(i));
	    	
	    	table_result.add(header);
	    	
	    	while(rs.next())
	    	{	
	    		List<Object> row = new ArrayList<>();
	    		for(int i=1; i<=column_count; i++)
	    		{
	    			DateTimeFormatter formatter= DateTimeFormatter.ofPattern("dd-MMM-yyyy\nhh:mm:ss a");
	    			Object o = rs.getObject(i);
	    			if(o == null)
	    				row.add("");
	    			else if(rsmd.getColumnName(i).equals("ENTRY_DT"))
	    				row.add(rs.getTimestamp(i).toLocalDateTime().format(formatter));
	    			else
	    				row.add(o);
	    		}
	    			
	    		table_result.add(row);
	    	}
		}catch(Exception e) {}
		return table_result;
	}

}
