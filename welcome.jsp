<!doctype html public "-//w3c//dtd html 3.2//en">
<html>
<!-- Copyright (c) 1999-2000 by BEA Systems, Inc. All Rights Reserved.-->

<head>
    <title>Employee List</title>
    <style>


        .bg {
            /* The image used */
            background-image: url("images/bg.jpg");

            /* Full height */
            height: 100%;

            /* Center and scale the image nicely */
            background-position: center;
            background-repeat: no-repeat;
            background-size: cover;
        }

        .card {
            box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
            transition: 0.3s;
            width: auto;
            padding: 5px;
            background-color:#f0f1f2;
            height:200px;
           
        }

        .card:hover {
            box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
        }

        .container {
            padding: 2px 16px;
        }

        * {
            box-sizing: border-box;
        }

        /* Create two equal columns that floats next to each other */
        .column-left {
            float: left;
            width: 30%;
            padding: 10px;
            height: auto;
            /* Should be removed. Only for demonstration */
        }

        .column-right {
            margin-top:275px;
            float: left;
            width: 70%;
            padding: 10px;
            height: auto;
            /* Should be removed. Only for demonstration */
        }

        /* Clear floats after the columns */
        .row:after {
            content: "";
            display: table;
            clear: both;
        }
    </style>
</head>

<body>
    <div class="bg">

    <font face="Helvetica">
        <div class="row">
            <div class="column-left" >


                <%@ page import="
java.sql.*,
java.util.*,
javax.naming.*
" %>

                <p>

                    <%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
Context context = null;
try {
    context = new InitialContext();
    javax.sql.DataSource ds;
    ds = (javax.sql.DataSource) context.lookup("demoPool");
  conn = ds.getConnection();
 // You can now use the conn object to create 
 //  Statements and retrieve result sets:
  stmt = conn.createStatement();
  stmt.execute("select * from employees");
  rs = stmt.getResultSet(); 
  // Get meta data of database
  DatabaseMetaData metaData = conn.getMetaData();  
  if (rs.next()) {
      String dbtype = rs.getString(5).toString();
      %>



                <p style="color:white">Application is connected to  </p>
                <h1 style="color:white"><%=dbtype%></h1>
                <br><br>
                <p style="color:white"><b>Connection Url:</b><br><%=metaData.getURL()%> </p>

                <% 
                if(dbtype.equals("onpremdb")){
                    %>
                                        <h4 style="color:white"> Weblogic Server Running On Premise</h4>
                                        <img src="https://conceptboard.com/wp-content/uploads/2015/07/enterprise__server-control.svg">

                                        <%
                          } else {
                            %>
                                        <h4 style="color:white"> Weblogic Server Running On PCA - Kubernetes</h4>
                                        <img src="https://www.oracle.com/technetwork/database/application-development/dbcs-logo-3402784.png" style="width:55%">
                                        <%
                          }
                    
                    } %>
            </div>

         
            <div class="column-right">
                <img src="images/weblogic.png" style="width:20%">
                <h1>
                    <font color=#ffffff>
                        Cusotmer List
                    </font>
                </h1>
                <div style="display:table-cell; text-align:center; vertical-align:middle;">
                    <table>
                        <tr>
                            <%
    while (rs.next()) {
    %>

                            <td>
                                <div class="card">
                                    <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/0/05/New_India_Assurance.svg/1200px-New_India_Assurance.svg.png"
                                        alt="Avatar" style="width:30%">
                                    <div class="container">
                                        <h4><b><%=rs.getString(3)%> <%=rs.getString(4)%></b></h4>
                                        <p>Customer No.: <%=rs.getInt(1)%><%=rs.getInt(2)%></p>
                                    </div>
                                </div>
                            </td>

                            <% } %>
                        </tr>
                    </table>
                </div>
            </div>

            <%
//Close JDBC objects as soon as possible
  stmt.close();
  stmt=null;
  conn.close();
  conn=null;
}
catch (Exception e) {
  System.out.println(e);
}
finally {    
try { 
    context.close(); 
} catch (Exception e) {
    System.out.println(e); }
try { 
  if (rs != null) rs.close(); 
} catch (Exception e) {  
    System.out.println(e); }
try { 
  if (stmt != null) stmt.close(); 
} catch (Exception e) {  
    System.out.println(e); }
try { 
  if (conn != null) conn.close(); 
} catch (Exception e) {  
    System.out.println(e); }
}
%>

        </div>

    </font>
</div>
</body>

</html>