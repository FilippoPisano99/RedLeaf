<%@page import="java.sql.*"%>
<% 
    String userName = session.getAttribute("userName")+"";
    String userRole = session.getAttribute("userRole")+"";
    String IDPage = request.getParameter("IDPage")+""; 
    
    String extraParam = session.getAttribute("extraParam")+"";
    
    String pageName = "Homepage";
    switch(IDPage){
        case "2":
            pageName = "Inventario";
            break;
    }
    
    String url = "jdbc:mysql://localhost:3306/gestionaleazienda?zeroDateTimeBehavior=convertToNull";
    Class.forName("com.mysql.jdbc.Driver").newInstance(); 
    Connection DB = DriverManager.getConnection(url,"root" , "vertrigo");

    if(( session.getAttribute("userName")+"" ).equals("null"))
    {
        response.sendRedirect("login.jsp");
    }
%>

<html>
    <head>
        <title>Gestionale Azienda</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" type="text/css" href="css/stile.css">
    </head>
    <body>
        
        <div id="ManagementTab">
            
            <div class="TitleTab">
                <h2><%= pageName %></h2>
                <div class="NavTab">
                    <a href="index.jsp?IDPage=0"><h2>Home</h2></a>
                    <a href="index.jsp?IDPage=1"><h2>Inventario</h2></a>
                </div>
            </div>
            <div id="ManagementTabContent">
            <% 
                switch(IDPage){
                    case "0":
                        %><%@include file="dashboard.jsp" %><% 
                    break;
                    
                    case "1":
                        %><%@include file="listaSedi.jsp" %><% 
                    break;
                    case "11":
                        %><%@include file="listaInventari.jsp" %><% 
                    break;
                    case "111":
                        %><%@include file="inventario.jsp" %><% 
                    break;
                    
                }
            %>
            </div>
           
        </div>
        
        
        <%@include file="userTab.jsp" %>
        
    </body>
    <footer>&copy; Copyright 2018 Filippo Pisano</footer>
</html>
