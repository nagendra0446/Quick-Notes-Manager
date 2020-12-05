<!DOCTYPE html>
<html>

<head>
<meta charset="ISO-8859-1">
<title>Sign Up to Quick Notes</title>
<link rel="stylesheet" href="css/profile_signup_style.css">
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Inter:wght@100;200;300;400;500;600;700;800;900&display=swap" rel="stylesheet">	<meta name="viewport" content="width=device-width, initial-scale=1.0">
</head>

<h1 align=center class=intro>Sign Up to <b style="color:#2D7D9A;">Quick Notes.</b></h1>

	<form class="input_area" action="AddUserServlet" method=POST onSubmit = "return checkStatus(this)">
		<table class="form_table" style="">
			<tr>
				<td>First Name: </td>
				<td><input type=text name="first_name" size="25" autofocus required></td>
			</tr>
			<tr>
				<td>Last Name: </td>
				<td><input type=text name="last_name" size="25"></td>
			</tr>
			<tr>
				<td>Email: </td>
				<td><input type=text name="email" size="30"></td>
			</tr>
			<tr>
				<td>Mobile: </td>
				<td><input type="tel" id="mobile" name="mobile" size="25"></td>
			</tr>
			<tr>
			<td colspan=2 style="text-align:center;"></td>
			</tr>
			<tr>
				<td>Set Username: </td>
				<td><input type=text name="uname" size="25" required></td>
			</tr>
			<tr>
				<td>Set Password: </td>
				<td><input id=password type=password name="pass" size="25" required  onkeyup='check();' /></td>
			</tr>
			<tr>
				<td>Confirm Password: </td>
				<td><input id=confirm_password type=password name="pass" size="25" required  onkeyup='check();' /></td>
			</tr>
			
			<tr>
				<td></td>
				<td>
					<input type="checkbox" onclick="myFunction()">Show Password
				</td>
			</tr>
			<tr>
			<td colspan=2 style="text-align:center;">
				<input class="add_notes" type=submit value="Sign Up">
			</td>
			</tr>
		</table>	
	</form>
	
</body>
<script>
	
function myFunction() {
	var x1 = document.getElementById("password");
	var x2 = document.getElementById("confirm_password");
		if (x1.type == "password" && x2.type == "password") {
			x1.type = "text";
			x2.type = "text";
		}else {
			x1.type = "password";
			x2.type = "password";
		}
	}
	
var password = document.getElementById("password");
var confirm_password = document.getElementById("confirm_password");

function validatePassword(){
if(password.value != confirm_password.value) {
  confirm_password.setCustomValidity("Passwords Don't Match");
} else {
  confirm_password.setCustomValidity('');
}
}

password.onchange = validatePassword;
confirm_password.onkeyup = validatePassword;
</script>
</html>