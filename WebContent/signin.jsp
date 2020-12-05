<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Quick Notes Sign In</title>
	<link rel="stylesheet" href="css/signin_style.css">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<body>

<%
	if(request.getHeader("User-Agent").contains("Mobi"))
		out.println("<h1 align=center class=intro>Welcome to <br><a class=intro_name>"+
				"Quick Notes</a><br> Sign in to get started.</h1>");
	else
		out.println("<h1 align=center class=intro>Welcome to <a class=intro_name>"+
				"Quick Notes</a><br> Sign in to get started.</h1>");
%>

<%
	String is_valid = (String)session.getAttribute("is_valid");
	String is_valid_session = (String)session.getAttribute("is_valid_session");
	String logout = request.getParameter("logout");
	String user_created = (String)session.getAttribute("user_created");
	String user_already_exists = (String)session.getAttribute("user_already_exists");
	
	if(is_valid != null && is_valid.equals("false"))
	{
		out.println("<script>alert('Invalid Username or Password');</script>");
		session.invalidate();
	}
	if(is_valid_session != null && is_valid_session.equals("false"))
	{
		out.println("<script>alert('Sorry, Session Expired!');</script>");
		session.invalidate();
	}
	if(logout != null && logout.equals("true"))
	{
		out.println("<script>alert('Log Out Successful');</script>");
		session.invalidate();
	}
	if(user_created != null && user_created.equals("true"))
	{
		out.println("<script>alert('Account Created');</script>");
		session.invalidate();
	}
	if(user_already_exists != null && user_already_exists.equals("true"))
	{
		out.println("<script>alert('The User already exists');</script>");
		session.invalidate();
	}
%>

<br>

<div class=signin_box align=center>
	<form action="SigninCheckServlet" method=POST>
		<div class=signin_head align="center">Sign in</div>
		<input class=text_inp type=text name="uname" placeholder="Username" required>
		<br>
		<input class=text_inp type=password name="pass" placeholder="Password" required>
		<br>
		<input class=signin_button type=Submit value="Sign in" placeholder="Password">
		<br>
		<!-- <a class=forgot_link href="#">Forgot Password?</a> -->  
		&nbsp;&nbsp;
		No Account? you can also
		 <a href="signup.jsp" class=signup_button>Sign Up</a>
	</form>	
</div>

</body>
</html>