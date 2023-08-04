<%@page import="java.io.PrintWriter"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.lang.Math" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css"
        integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
<title>Insert title here</title>
</head>
<body>

<div id="nav-placeholder"></div>
<script src="//code.jquery.com/jquery.min.js"></script>
<script>
$.get("navbar.html", function(data){
    $("#nav-placeholder").replaceWith(data);
});
</script>
<%
int total = 0, pgno = 0, pageNo = 0;
int start = 0, recordCount = 10;

int count = 1;
pgno = request.getParameter("pgno") == null ? 0 : Integer.parseInt(request.getParameter("pgno"));
start = pgno * recordCount;
try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection con =DriverManager.getConnection("jdbc:mysql://localhost:3306?user=root&password=root");
	String sql = "SELECT * FROM ngo.info LIMIT ?,?";
	PreparedStatement pst = con.prepareStatement(sql);
	pst.setInt(1, start);
	pst.setInt(2, recordCount);
	ResultSet rs = pst.executeQuery();
	PrintWriter pw = response.getWriter();
pw.print("<table class='table'><thead class='thead-dark'><tr><th scope='col'>Sr. No.</th><th scope='col'>");
pw.print("Name"+"</th><th scope='col'>"+"Address"+"</th><th scope='col'>"+"Mobile No."+"</th><th scope='col'>"+"DOB"+"</th><th scope='col'>"+"Email"+"</th><th scope='col'>"+
"Relative Name"+"</th><th scope='col'>"+"Mobile No."+"</th><th scope='col'>"+"Relation"+"</th><th scope='col'>"+"Relative Address"+"</th><th scope='col'>"+"Hospital Name"+"</th><th scope='col'>"+"Reg No."+"</th><th scope='col'>"+"Status");

pw.print("</th></tr></thead><tbody>");
while(rs.next()){

	
   
    String fname =rs.getString(1);
    String mname =rs.getString(2);
    String last =rs.getString(3);
    String address =rs.getString(4);
    String city =rs.getString(5);
    String state =rs.getString(6);
    String pin =rs.getString(7);
    String mob_no =rs.getString(8);
    String dob =rs.getString(9);
    String email =rs.getString(10);
    String relative =rs.getString(11);
    String rmob =rs.getString(12);
    String rrel =rs.getString(13);
    String radd =rs.getString(14);
    String hosn =rs.getString(15);
    String regn =rs.getString(16);
    int id = rs.getInt(17);
    String status = regn.isEmpty() ? "Incomplete" : "Complete";
    pw.print("<tr><td>");
    pw.print(id + "</td><td>" + fname + " " + mname + " " + last + "</td><td>" + address + " " + city + " " + state + " " + pin +
    "<td>" + mob_no + " " + "</td><td>" + dob + "</td><td>" + email + " " + "</td><td>" + relative + "</td><td>" +
    rmob + " " + "</td><td>" + rrel + " "+ " </td><td>" + radd+" " + "</td><td>" + hosn + " " + "</td><td>");
    // Check if registration number is empty or not
    if (regn.isEmpty()) {
    	pw.print("<form method='post' action='update_reg.jsp'>");
    pw.print("<input type='text' name='regn' placeholder='Enter Registration Number' />");
    pw.print("<input type='hidden' name='id' value='" + id + "' />");
    pw.print("<input type='submit' value='Update' />");
    pw.print("</form>");
    } else {
    pw.print(regn);
    }
    pw.print("</td><td>" + status);
    	pw.print("</td></tr>");
    	}
String sql1 = "SELECT COUNT(*) FROM ngo.info";
PreparedStatement smt2 = con.prepareStatement(sql1);
ResultSet rs2 = smt2.executeQuery();
if (rs2.next()) {
	total = rs2.getInt(1);
}

pst.close();
con.close();

} catch (ClassNotFoundException e) {
e.printStackTrace();
} catch (SQLException e) {
e.printStackTrace();
}


%>

 </tbody>
      </table>

	<span style="float: left"><a href="Data.jsp?pgno=<%= Math.max(0, pgno - 1) %>"
			class="btn btn-dark <%= (start == 0) ? "disabled" : "" %>">Previous</a></span>
	<span style="float: right"><a href="Data.jsp?pgno=<%= Math.min((total - 1) / recordCount, pgno + 1) %>"
			class="btn btn-dark <%= (start + recordCount >= total) ? "disabled" : "" %>">Next</a></span>

      
</body>
</html>