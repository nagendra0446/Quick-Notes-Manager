<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Update Notes</title>
<link rel="stylesheet" href="css/add_update_form.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
</head>

<body>
<%
	if(session.getAttribute("userid") == null)
	{
		session.setAttribute("is_valid_session", "false");
		response.sendRedirect("signin.jsp");
	}

	else if(request.getParameter("NOTES") == null)
	{
		response.sendRedirect("notes_home.jsp");
	}
%>

<h1 align="center">Update Your Notes</h1>

<div class="input_area">

<form action="UpdateServlet" method=POST>

<input type=hidden name="S_NO" value="<%= request.getParameter("S_NO") %>">

<input class="title" type=text name="TITLE" placeholder="Title" value="<%= request.getParameter("TITLE") %>"  autofocus required>
<br>

<textarea name="NOTES" rows="11" placeholder="Add Your Notes Here" 
	required style="resize: vertical;"><%= request.getParameter("NOTES") %></textarea>
<br>

<select name="STATUS">
	<%= generateOptions(request) %>
</select>
<br>


<input class="update_notes" type=submit value="UPDATE NOTES">

</form>
</div>

<br>
<br>



<%!
String getFilteredParameter(HttpServletRequest request, String name)
{
	String raw_value = request.getParameter(name);
	if(raw_value == null)
		return "";
	else
		return raw_value;
	
}
%>

<%! 
String generateOptions(HttpServletRequest request)
{
	if(request.getParameter("STATUS") == null)
	{
		return "<option value=\"PENDING\" selected>PENDING</option>"+
				"<option value=\"COMPLETED\">COMPLETED</option>"+
				"<option value=\"IN-PROGRESS\">IN-PROGRESS</option>"+
				"<option value=\"SKIPPED\">SKIPPED</option>";
	}
	else if(request.getParameter("STATUS").equals("PENDING"))
	{
		return "<option value=\"PENDING\" selected>PENDING</option>"+
				"<option value=\"COMPLETED\">COMPLETED</option>"+
				"<option value=\"IN-PROGRESS\">IN-PROGRESS</option>"+
				"<option value=\"SKIPPED\">SKIPPED</option>";
	}
	else if(request.getParameter("STATUS").equals("COMPLETED"))
	{
		return "<option value=\"PENDING\">PENDING</option>"+
				"<option value=\"COMPLETED\" selected>COMPLETED</option>"+
				"<option value=\"IN-PROGRESS\">IN-PROGRESS</option>"+
				"<option value=\"SKIPPED\">SKIPPED</option>";
	}
	else if(request.getParameter("STATUS").equals("IN-PROGRESS"))
	{
		return "<option value=\"PENDING\">PENDING</option>"+
				"<option value=\"COMPLETED\">COMPLETED</option>"+
				"<option value=\"IN-PROGRESS\" selected>IN-PROGRESS</option>"+
				"<option value=\"SKIPPED\">SKIPPED</option>";
	}
	else if(request.getParameter("STATUS").equals("SKIPPED"))
	{
		return "<option value=\"PENDING\">PENDING</option>"+
				"<option value=\"COMPLETED\">COMPLETED</option>"+
				"<option value=\"IN-PROGRESS\">IN-PROGRESS</option>"+
				"<option value=\"SKIPPED\" selected>SKIPPED</option>";
	}
	else
	{
		return "<option value=\"PENDING\">PENDING</option>"+
				"<option value=\"COMPLETED\">COMPLETED</option>"+
				"<option value=\"IN-PROGRESS\">IN-PROGRESS</option>"+
				"<option value=\"SKIPPED\">SKIPPED</option>";
	}
	
}

%>

</table>
</body>
</html>