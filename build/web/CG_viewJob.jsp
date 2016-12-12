<%-- 
    Document   : CG_viewJob
    Created on : Dec 5, 2016, 9:08:17 PM
    Author     : DanQiao
--%>

<%@page import="java.sql.*" %>
<%@page import="java.sql.Connection"%>
<% Class.forName("com.mysql.jdbc.Driver"); %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>




    <head>
        <title>Nurse view all job Page</title>
    </head>
    
        

<%
     if("POST".equalsIgnoreCase(request.getMethod())){
      
            String user = session.getAttribute("username").toString() ;
            
            Connection con= null;
                PreparedStatement ps;
                ResultSet rs;
                String query;
                PreparedStatement ps1;
                ResultSet rs1;
                String query1;
                try{
                    Class.forName("com.mysql.jdbc.Driver");
                }catch(Exception e)
                {
                    System.out.println(e);
                }
                
                try{
                    con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Healthcare", "root", "root");
                    query ="SELECT CG_ID from Caregivers Where CG_Username = ? ";
                    ps = con.prepareStatement(query);
                    ps.setString(1, user);
                    rs = ps.executeQuery();
                    int indexID = 0;
                    if(rs.next()){
                                    indexID = rs.getInt("CG_ID");
                                }else{
                                   out.println("No this Nurse");
                                }
                   
                    query1 = "SELECT * FROM Appointments WHERE NurseID= ? ";
                    ps1 = con.prepareStatement(query1);
                    ps1.setInt(1, indexID);
                    rs1 = ps1.executeQuery();
                    
//                    if(rs.first())
//                    {
%>
<table border="1">
    <thead>
        <tr bgcolor="#DEB887">
            <th>Appointment_ID</th>
            <th>Final_Time</th>
            <th>Request_ID</th>
            <th>Status</th>
            <th>Option1</th>
            <th>Option2</th>
            <th>Option3</th>
        </tr>
    </thead>
    <tbody>
        <% while (rs1.next()) {
            String a = "";
            String b = "";
            String time = rs1.getString("Final_Time");
            String idn = rs1.getString("Request_ID");
            String status = rs1.getString("StatusID");
//            session = request.getSession();
//            session.setAttribute("submitid", idn);
            
            if(time.endsWith("9")){
                a = "9-10AM";
            }
            if(time.endsWith("11")){
                a = "11-12AM";
            }
            if(time.endsWith("2")){
                a = "2-3PM";
            }
            if(time.endsWith("9")){
                a = "4-5PM";
            }
            if(status.equalsIgnoreCase("1")){
                b = "Submitted";
            }
            if(status.equalsIgnoreCase("2")){
                b = "Allocated";
            }
            if(status.equalsIgnoreCase("3")){
                b = "Cancelled";
            }
            if(status.equalsIgnoreCase("4")){
                b = "Completed";
            }
        %>
        <tr>
            <td><%=rs1.getString("AppointmentID")  %></td>
            <td><%=a%></td>
            <td><%=rs1.getString("Request_ID")  %></td>
            <td><%=b%></td>
            <td>
                <form action="cancellog.jsp" method="GET">
                <input type="submit" value="Cancel" name="cancel" />
                <input type="hidden" name= "button1" value=<%=idn%> />
                </form>
            </td>
            <td>
                <form action="complog.jsp" method="GET">
                <input type="submit" value="Completed" name="completed" />
                <input type="hidden" name= "button" value=<%=idn%> />
                </form>
<!--                <a herf="complog.jsp?id=idn">completed</a>-->
            </td>
            <td>
                <form action="View_P_Addr.jsp" method="POST">
                <input type="submit" value="View_Address" name="view" />
                <input type="hidden" name= "button2" value=<%=idn%> />
                </form>
<!--                <a herf="complog.jsp?id=idn">completed</a>-->
            </td>
        </tr>
        <% } %>
    </tbody>
</table>
    <form action="Nurse_home.jsp">
            <input type="submit" value="Return" name="Return" />
        </form>

<%
//                        System.out.println(rs.getInt("Request_ID"));
//                        System.out.println(rs.getString("P_ID"));

//                    }
//                    else{
//                        
//                    }
                    
                }catch(SQLException e)
                {
                    System.out.println(e);
                }
            }
%>
