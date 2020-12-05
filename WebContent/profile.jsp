<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import = "java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>User Profile</title>
<link rel="stylesheet" href="css/about_style.css">
<link rel="stylesheet" href="css/profile_signup_style.css">

<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>
<body>
	<h1 align=center class=intro><b style="color:#2D7D9A;">Profile</b></h1>
	
	<%! List<Object> member_result=null; %>
	
	<% 
		if(session.getAttribute("userid") == null)
		{
			session.setAttribute("is_valid_session", "false");
			response.sendRedirect("signin.jsp");
		}
		else if(session.getAttribute("member_result") == null)
		{
			RequestDispatcher dispatcher = request.getRequestDispatcher("/ReadMemberServlet");
			request.setAttribute("jsp_name", "profile.jsp");
			dispatcher.forward(request, response);
		}	
		else
		{
			member_result = (List<Object>)session.getAttribute("member_result");
			session.setAttribute("member_result", null);
		}	
	%>

	<table class="profile_table">
	<tr>
		<td><b>First Name: </b></td>
		<td>
			<%= getFiltered(member_result, 0) %>
		</td>
	</tr>

	<tr>
		<td><b>Last Name: </b></td>
		<td>
			<%= getFiltered(member_result, 1) %>
		</td>
	</tr>

	<tr>
		<td><b>Email: </b></td>
		<td>
			<%= getFiltered(member_result, 2) %>
		</td>
	</tr>

	<tr>
		<td><b>Mobile: </b></td>
		<td>
			<%= getFiltered(member_result, 3) %>
		</td>
	</tr>

	<tr>
	    <td colspan=2 style="text-align:center;"></td>
	</tr>

	<tr>
		<td><b>Username: </b></td>
		<td>
			<%= getFiltered(member_result, 4) %>
		</td>
	</tr>

	<tr>
		<td><b>Password:</b> </td>
		<td>
		<input type=password id=pass style="background-color: #e0ece4;"value=
			<%= getFiltered(member_result, 5) %>>
		</td>
	</tr>
	
	<tr>
		<td></td>
		
		<td><input align=right type="checkbox" onclick="myFunction()">Show Password</td>
		
	</tr>

	</table>
	
	<h1 class=about_heading align=left>
        <a href="notes_home.jsp" class="return_button">Return to Quick Notes</a> 
    </h1>
	
<%!
	String getFiltered(List<Object> member_result, int index)
	{
		if(member_result == null)
			return "";
		else
			return member_result.get(index).toString();
	}
%>

</body>
<script>
	function myFunction() {
  		var x = document.getElementById("pass");
  		if (x.type == "password") {
    		x.type = "text";
  		}else {
   	 	x.type = "password";
  		}
	}
</script>	
</html>