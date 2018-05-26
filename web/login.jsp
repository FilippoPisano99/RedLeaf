<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<html>
    <head>
        <title>Gestionale d'Azienda</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="shortcut icon" href="res/favicon.png" />

        <link rel="stylesheet" type="text/css" href="css/stile.css">
        <link rel="stylesheet" type="text/css" href="css/loginBox.css">
        <link rel="stylesheet" type="text/css" href="css/managementBox.css">


    </head>
    <body>

        <%
            session.setAttribute("userName", null);
            session.setAttribute("role", null );
            session.setAttribute("inventario_aperto", null );
            session.setAttribute("tabPage", 1 );
            session.setAttribute("extraParam", "" );
            String userName = (String)request.getParameter("userName")+"";
            String userPwd = (String)request.getParameter("userPwd")+"";

            if(!userPwd.equals("null") && !userName.equals("null"))
            {
                String url = "jdbc:mysql://localhost:3306/gestionaleazienda";
                Class.forName("com.mysql.jdbc.Driver").newInstance();
                Connection DB = DriverManager.getConnection(url,"root" , "vertrigo");
                if(!DB.isClosed())
                {
                    int rowCount = 0;
                    Statement stmt = DB.createStatement();
                    ResultSet rs = stmt.executeQuery("SELECT u.userName,u.userPwd,u.ruolo,r.nome FROM user u JOIN rubrica r ON u.id_rubrica = r.id_rubrica where userName = '" +userName+ "'");
                    while(rs.next())
                    {
                        String userNameDB =  rs.getString("userName");
                        String userPwdDB =  rs.getString("userPwd");
                        String userRoleDB =  rs.getString("ruolo");
                        String name = rs.getString("nome");

                        if(userNameDB.equalsIgnoreCase(userName) && userPwdDB.equals(userPwd))
                        {
                            //Login
                            session.setAttribute("userName", userNameDB);
                            session.setAttribute("name", name);
                            session.setAttribute("role", userRoleDB);
                            response.sendRedirect("index.jsp?IDPage=0");

                        }
                        else
                        {
                            %>
                            <div id="logMsgBox" >
                                <h1>Credenziali Errate</h1>
                                <a class="regLink" href="login.jsp">Torna alla pagina di login</a>
                            </div>
                            <%
                        }
                        rowCount++;
                        break;
                    }

                    if(rowCount == 0)
                    {
                        if(!userPwd.equals("null") && !userName.equals("null"))
                        {
                            %>
                            <div id="logMsgBox" >
                                <h1>Credenziali Errate</h1>
                                <a href="login.jsp">Torna alla pagina di login</a>
                            </div>
                            <%
                        }
                        else
                        {
                        %>
                        <div id="LoginTab">
                            <div class="TitleTab">
                                <h2>Login</h2>
                            </div>
                            <form method="POST" action="login.jsp">
                                <p>Username:</p>
                                <input type="text" name="userName">
                                <p>Password:</p>
                                <input type="password" name="userPwd">
                                <br><br>
                                <input type="submit" value="Login">
                            </form>

                        </div>
                        <%
                        }
                    }

                }

                DB.close();
            }
            else
            {
                %>
                <div id="LoginTab">
                    <div class="TitleTab">
                        <h2>Login</h2>
                    </div>
                    <form method="POST" action="login.jsp">
                        <p>Username:</p>
                        <input type="text" name="userName">
                        <p>Password:</p>
                        <input type="password" name="userPwd">
                        <br><br>
                        <input type="submit" value="Login">
                    </form>

                </div>
                <%
            }
        %>


    </body>
</html>
