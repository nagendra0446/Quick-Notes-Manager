<%@ page import = "java.util.*" %>
<%@ page import = "my_pack.ColorInfo" %>
<%@ page import = "my_pack.ColorInfo.*" %>
<%@ page import = "my_pack.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Notes Home</title>
<link rel="stylesheet" href="css/notes_home_style.css">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>

<h1 align=center> <b style="color: #2d7d9a">Quick Notes</b></h1>




<%
	if(request.getHeader("User-Agent").contains("Mobi"))
		out.println("<div class=user_info_mobile>");
	else
		out.println("<div class=user_info_pc>");
%>
	<img src="images/user_icon.png" alt="" width=45px>
	<br>
	<%= session.getAttribute("userid") %>
    <form action="profile.jsp"  method=post>
		<input class="profile_button" style=" font-family: inter;" type=submit value="View Profile">
    </form>
    <form action="signin.jsp" method=post>
    	<input type="hidden" name="logout" value="true" >
       	<input class="logout_button" onclick= "return confirm('Are you sure you want to Log Out?');" style= "font-family: inter;" type=submit value="Log Out">
	</form>
	
	<table class="about_main">
	<tr>
	<th class="about" onclick="location.href='about.html';">
    	<img src="images/info_symbol.png" width="30px" >
       	<th class="about_text" onclick="location.href='about.html';">About
	</th>
	</tr>
</table>
</div>

<%
	if(request.getHeader("User-Agent").contains("Mobi"))
		out.println("<hr width=90% class=line noshade>");
%>

<table class="add_area">
	<tr>
		<td class="add_area">
			<form action="add_notes_form.jsp">
				<input style="display: inline-block;" type=image src="images/add.png" width=65px height=65px>
			</form>
		</td>
		<td class="add_area">ADD NOTES</td>
	</tr>
</table>
<br>

<% 
	if(session.getAttribute("userid") == null)
	{
		session.setAttribute("is_valid_session", "false");
		response.sendRedirect("signin.jsp");
	}

	else if(session.getAttribute("table_result") == null)
	{
		RequestDispatcher dispatcher = request.getRequestDispatcher("/ReadAllServlet");
		request.setAttribute("jsp_name", "notes_home.jsp");
		dispatcher.forward(request, response);
	}	
	else
	{
		List<List<Object>> table_result = (List<List<Object>>)session.getAttribute("table_result");
		int cc=0;
		int i = 1;
		for(List<Object> row : table_result)
		{
			if(i++ <= 1)
				continue;
			
		    if(cc>=4) cc=0;
		    out.println("<table class=note_model style=\"background-color: "+ColorInfo.getColor(cc++)+";\"");
			out.println("<tr>");
				out.println("<td class=title>"+row.get(1)+"</td>");
				out.println("<td class=status>"+row.get(3)+"</td>");

				out.println("<td rowspan=2 valign=middle class=edit_opt>");
					out.println("<form action=update_notes_form.jsp method=post>");
					out.println("<input type=hidden name=S_NO value=\""+row.get(0)+"\">");
					out.println("<input type=hidden name=TITLE value=\""+row.get(1)+"\">");
					out.println("<input type=hidden name=NOTES value=\""+row.get(2)+"\">");
		            out.println("<input type=hidden name=STATUS value=\""+row.get(3)+"\">");
					out.println("<input class=edit type=image src=\"images/edit.png\" width=40px height=40px style=\"margin:0px;\"> </form>");

		        out.println("<form action=DeleteServlet method=post>");
					out.println("<input type=hidden name=S_NO value="+row.get(0)+">");
					out.println("<input class=delete type=image src=\"images/delete.png\" width=40px height=40px style=\"margin:0px;\" onclick=\"return confirm('Do you want to delete the notes:"+row.get(1)+" ?');\"> </form>");
				out.println("</td>");
			out.println("</tr>");
			out.println("<tr>");
				out.print("<td colspan=2 class=notes valign=top>");out.print(row.get(2));out.println("</td>");
			out.println("</tr>");
		    out.println("</table>");
		}
		session.setAttribute("table_result", null);
	}	
%>

</body>
</html>