<div id="UserTab">
    <div class="TitleTab">
        <h2><%= nomeRub %></h2>
        <%
        if( role.equals("Admin") ){
            out.println("<small>"+ role + "</small>");
        }
        %>
    </div>

    <a href="clearSession.jsp">
        <div class="UserTabBtn">
            Home
        </div>
    </a>
    <%
    if( role.equals("Admin") )
    {
        %>
        <a href="index.jsp?IDPage=-1" >
            <div class="UserTabBtn">
                Gestione dipendenti
            </div>
        </a>
        <%
    } %>

    <br>

    <a href="login.jsp">
        <div id="logoutBox">
            Esci
        </div>
    </a>
</div>
