<%@ page import="java.sql.*" %>
<%@include file="functions.jsp" %>

<%
    String url = "jdbc:mysql://localhost:3306/gestionaleazienda";
    Class.forName("com.mysql.jdbc.Driver").newInstance();
    Connection DB = DriverManager.getConnection(url,"root" , "vertrigo");
    if(!DB.isClosed())
    {

        if(request.getParameter("action")!=null){

            if(request.getParameter("action").equals("create")){

                String ID_rubrica="";
                String ruolo = "Normale";

                ResultSet rs = executeQuery(session, "SELECT id_rubrica FROM rubrica WHERE nome='"+request.getParameter("n")+"'" );
                while(rs.next()){
                    ID_rubrica = rs.getString("id_rubrica");
                    break;
                }


                executeUpdate(session, "UPDATE rubrica "
                    + "SET "
                    + "id_sede='"+session.getAttribute("id_sede")+"', "
                    + "nome='"+request.getParameter("nome")+"', "
                    + "cognome='"+request.getParameter("cognome")+"', "
                    + "indirizzo='"+request.getParameter("indirizzo")+"', "
                    + "citta='"+request.getParameter("citta")+"', "
                    + "codice_fiscale='"+request.getParameter("cf")+"', "
                    + "telefono='"+request.getParameter("telefono")+"', "
                    + "email='"+request.getParameter("email")+"' "
                    + "WHERE nome = '" +request.getParameter("n")+ "'" );


                if(request.getParameter("r").equals("A"))
                {
                    ruolo="Admin";
                }

                executeInsert(session , "INSERT INTO user VALUES (NULL , "+
                "'"+request.getParameter("username")+"', "+
                "'"+request.getParameter("password")+"', "+
                "'"+ruolo+"', "+
                "'"+ID_rubrica+"' )");

            }

        }


    }

    DB.close();
%>
<html>
<head>
    <title>Gestionale Azienda</title>
    <meta charset="UTF-8">
    <link rel="shortcut icon" href="favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- LOAD UP RES -->
    <link rel="stylesheet" type="text/css" href="res/MaterialIcons.css">
    <link rel="stylesheet" type="text/css" href="res/RobotoImport.css">

    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="css/stile.css">
    <link rel="stylesheet" type="text/css" href="css/toolBox.css">
    <link rel="stylesheet" type="text/css" href="css/managementBox.css">
    <link rel="stylesheet" type="text/css" href="css/userBox.css">
    <link rel="stylesheet" type="text/css" href="css/signinBox.css">

</head>
<body>

    <div id="SigninTab" >
        <div class="TitleTab">
            <h2>Registrazione</h2>
        </div>
        <form method="POST" action="signin.jsp">
            <input type="hidden" name="action" value="create">
            <input type ="hidden" value="<%= request.getParameter("n") %>" name="n">
            <input type ="hidden" value="<%= request.getParameter("r") %>" name="r">

            <br>

            <p>Username:</p><input type='text' name='username'><br>
            <p>Password:</p><input type='text' name='password'><br>

            <br>

            <p>Nome:</p><input type='text' name='nome'><br>
            <p>Cognome:</p><input type='text' name='cognome'><br>
            <p>Indirizzo:</p><input type='text' name='indirizzo'><br>
            <p>Telefono:</p><input type='text' name='telefono'><br>
            <p>E-mail:</p><input type='email' name='email'><br>
            <p>Citt&agrave;:</p><input type='text' name='citta'><br>
            <p>Codice Fiscale:</p><input type='text' name='cf'><br>
            <br>
            <input type="submit" >
        </form>

    </div>
</body>

</html>
