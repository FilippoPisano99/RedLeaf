<%@page import="java.sql.*"%>
<%
    String userName = session.getAttribute("userName")+"";
    String userRole = session.getAttribute("userRole")+"";
    String IDPage = request.getParameter("IDPage")+"";

    String extraParam = session.getAttribute("extraParam")+"";

    String pageName = "Homepage";
    String pageCategory = IDPage.charAt(0)+"";
    switch(pageCategory){
        case "0":
            pageName = "Homepage";
            break;
        case "1":
            pageName = "Inventario";
            break;
        case "2":
            pageName = "Rubrica";
            break;
        case "3":
            pageName = "Fornitori";
            break;
        case "4":
            pageName = "Articoli";
            break;
    }

    String url = "jdbc:mysql://laptop-pisi:3306/gestionaleazienda?zeroDateTimeBehavior=convertToNull";
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    Connection DB = DriverManager.getConnection(url,"root" , "vertrigo");
    ResultSet rs;

    session.setAttribute("DB", DB);

    if(( session.getAttribute("userName")+"" ).equals("null"))
    {
        response.sendRedirect("login.jsp");
    }
%>
<%@include file="functions.jsp" %>
<html>
    <head>
        <title>Gestionale Azienda</title>
        <meta charset="UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

        <link rel="stylesheet" type="text/css" href="css/stile.css">
        <link rel="stylesheet" type="text/css" href="css/toolBox.css">
        <link rel="stylesheet" type="text/css" href="css/managementBox.css">
        <link rel="stylesheet" type="text/css" href="css/userBox.css">
        <link rel="stylesheet" type="text/css" href="css/deleteBox.css">
        <link rel="stylesheet" type="text/css" href="css/table.css">
        <link rel="stylesheet" type="text/css" href="css/identityCardBox.css">
    </head>
    <body>
        <div>
        <%@include file="userTab.jsp" %>

        <div id="ManagementTab">

            <div class="TitleTab">
                <h2><%= pageName %></h2>

            </div>
            <div id="ManagementTabContent">

            <%
                switch(IDPage){
                    case "0":
                        %><%@include file="dashboard.jsp" %><%
                    break;
                    /////////////////////////////////////////////////////////
                    case "1":
                        %><%@include file="INV/listaSedi.jsp" %><%
                    break;
                    case "11":
                        %><%@include file="INV/listaInventari.jsp" %><%
                    break;
                    case "111":
                        %><%@include file="INV/inventario.jsp" %><%
                    break;
                    /////////////////////////////////////////////////////////
                    case "2":
                        %><%@include file="RUB/listaSedi.jsp" %><%
                    break;
                    case "21":
                        %><%@include file="RUB/listaContatti.jsp" %><%
                    break;
                    case "211":
                        %><%@include file="RUB/contatto.jsp" %><%
                    break;
                    /////////////////////////////////////////////////////////
                    case "4":
                        %><%@include file="ART/listaSedi.jsp" %><%
                    break;
                    case "41":
                    break;
                    case "411":

                    break;
                }
            %>
            </div>

        </div>

        </div>


    </body>
    <!--
        <footer>&copy; Copyright 2018 Filippo Pisano</footer>
    -->
</html>
