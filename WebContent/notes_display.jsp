<%@ page import = "java.util.*" %>
<%@ page import = "my_pack.ColorInfo" %>
<%@ page import = "my_pack.ColorInfo.*" %>
<%@ page import = "my_pack.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Notes Display</title>
<link rel="stylesheet" href="css/notes_style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet"><meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<!-- <h1 align=center>Your <b style="color: #2d7d9a">Quick Notes</b></h1> -->


<% 
	RequestDispatcher dispatcher = 
		request.getRequestDispatcher("/ReadAllServlet");

	if(request.getAttribute("table_result") == null)
	{
		request.setAttribute("jsp_name", "notes_display.jsp");
		dispatcher.forward(request, response);
	}
		
	else
	{
		
		List<List<Object>> table_result = (List<List<Object>>)request.getAttribute("table_result");
		
		
		int cc=0;
		for(List<Object> row : table_result)
		{
		    if(cc>=4) cc=0;
		    out.println("<table class=note_model style=\"background-color: "+ColorInfo.getColor(cc++)+";\"");
			out.println("<tr>");
				out.println("<td class=title>"+row.get(1)+"</td>");
				out.println("<td class=status>"+row.get(2)+"</td>");

			out.println("</tr>");
			out.println("<tr>");
				out.print("<td colspan=2 class=notes valign=top>");out.print(row.get(3));out.println("</td>");
			out.println("</tr>");
		    out.println("</table>");
		}
	}	
%>

</body>
</html>