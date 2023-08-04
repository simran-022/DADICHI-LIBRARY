<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>दधीचि : वाढदिवस</title>
<style>
h4{
top-margin:100px;
}
</style>
</head>
<body>
<div id="nav-placeholder"></div>
<script src="//code.jquery.com/jquery.min.js"></script>
<script>
$.get("navbar1.html", function(data){
   $("#nav-placeholder").replaceWith(data);
});
</script>
<%
int count = 0;
SimpleDateFormat format = new SimpleDateFormat("MM-dd");
Date d = new Date();
String currentDate = format.format(d);
String currentMonth = currentDate.substring(0, 2); // Extract the month part from the current date
try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306?user=root&password=root");
	PreparedStatement pst=con.prepareStatement("select * from ngo.info");
	ResultSet rs =pst.executeQuery();
	PrintWriter pw=response.getWriter();
	boolean hasBirthdays = false;
boolean a=false;
pw.print("<table class='table table-striped'><tbody>");
	while (rs.next()) {
		
		String dob_db=rs.getString("dob");
		String birthMonth = dob_db.substring(5, 7); // Extract the month part from the date of birth
		dob_db= dob_db.substring(5);
		
		if (birthMonth.equals(currentMonth)) { // Compare the birth month with the current month
           count++;
           pw.print("<tr><td>");
           pw.print("या महिन्यातील वाढदिवस<br>");
           pw.print(rs.getString(1) + " " + rs.getString(2) + " " + rs.getString(8));
           pw.print("</td></tr>");
           hasBirthdays = true;
       }
		
	}
	
	if (!hasBirthdays) {
       pw.print("<tr><td>");
       pw.print("या महिन्यात वाढदिवस नाहीत<br>");
       pw.print("</td></tr>");
   }
	
	
	} catch (Exception e) {
	// TODO Auto-generated catch block
	e.printStackTrace();
}
session.setAttribute("count", count);
%>
 </tbody>
</table>
</body>
</html>
