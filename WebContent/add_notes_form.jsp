<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Add Your Notes</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="css/add_update_form.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet"></head>

<body>

<%

	if(session.getAttribute("userid") == null)
	{
		session.setAttribute("is_valid_session", "false");
		response.sendRedirect("signin.jsp");
	}

%>

<h1 align=center>Add your <b style="color: #2d7d9a">Notes</b></h1>
<div class="input_area">
<form action="AddServlet" method=POST>

	<input class="title" type=text name="TITLE" placeholder="Title" autofocus>
	<br>

	<textarea name="NOTES" rows="11" placeholder="Add Your Notes Here" 
	required style=""></textarea>
	
	Status: 
	<select class="status" name="STATUS">
		<option value="PENDING">PENDING</option>
		<option value="COMPLETED">COMPLETED</option>
		<option value="IN-PROGRESS">IN-PROGRESS</option>
		<option value="SKIPPED">SKIPPED</option>
	</select>
	<br>
	
	<!--   <input type=text name="REMARKS" placeholder="Remarks">
	<br> -->

	<input class="add_notes" type=submit value="ADD NOTES">

</form>
</div>

</body>
</html>