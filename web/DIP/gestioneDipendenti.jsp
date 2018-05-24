<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.*"%>
 <div class="NavTab">
    <a href="index.jsp?IDPage=-1"><h2>< BACK</h2></a>
</div>
<%
    session.setAttribute("id_sede", request.getParameter("id_sede"));

    if(request.getParameter("action")!=null)
    {
        if(request.getParameter("action").equals("create")){

            String nomeRandom = generaStringaRandom();
            String lavoro = null;

            if(!request.getParameter("tipo").equals("A")){
                lavoro =  request.getParameter("lavoro");
            }


            executeInsert(session, "INSERT INTO rubrica "
                + "VALUES (NULL, "
                + ""+session.getAttribute("id_sede")+", "
                + "'"+nomeRandom+"', "
                + "'',"
                + "'',"
                + "'', "
                + "NULL, "
                + "'', "
                + "'', "
                + "'', "
                + "'"+request.getParameter("tipo")+"', "
                + "'"+lavoro+"')");

            session.setAttribute("newRegLink","signin.jsp?n="+nomeRandom+"&r="+request.getParameter("tipo"));


        }
        else if(request.getParameter("action").equals("delete"))
        {
            executeUpdate(session,"DELETE FROM rubrica WHERE id_rubrica = " +request.getParameter("id_rubrica"));
        }
    }

%>
<h1>Seleziona un dipendente</h1>
<table id="MainTableStyle">
    <tr>
        <th>NOMINATIVO</th>
        <th>TELEFONO</th>
        <th>RUOLO</th>
    </tr>
  <%
    rs = executeQuery(session,"SELECT r.id_rubrica,r.nome,r.cognome,r.telefono,r.lavoro FROM rubrica r WHERE r.tipo = 'D' AND r.id_sede=" + session.getAttribute("id_sede") );
    while(rs.next())
    {
        out.println("<tr>");

        out.println("<td>");
        out.println(rs.getString("nome")+" "+rs.getString("cognome"));
        out.println("</td>");


        out.println("<td>");
        out.println(rs.getString("telefono"));
        out.println("</td>");


        out.println("<td>");
        out.println(rs.getString("lavoro"));
        out.println("</td>");


        out.println("</tr>");
    }
  %>
</table>

<div class="sideModifyBox">
    <form class='toolBoxForm' method="get" action='index.jsp'>
            <div class="TitleTab">
                <h3>Aggiungi un utente</h3>
            </div>
            <input type ="hidden" value="-11" name="IDPage">
            <input type ="hidden" value="create" name="action">
            <input type ="hidden" value="<%= session.getAttribute("id_sede") %>" name="id_sede">

            <p>Tipo di utemte:</p>
            <select name="tipo" id="tipoSelect">
                <option value="D">Dipendente</option>
                <option value="A">Admin</option>
            </select>
            <br>

            <span id="spanLavoro">
                <p>Lavoro:</p><input type='text' name='lavoro'><br>
            </span>


            <%
                if( session.getAttribute("newRegLink") != null  )
                {
                    out.println("<a class='regLink' href='");
                    out.println(session.getAttribute("newRegLink"));
                    out.println("' > <p>Condividi questo link con il nuovo utente</p> </a>");
                    session.setAttribute("newRegLink",null);
                }
            %>


            <input type='submit' class="submitButton" value='Aggiungi'>

    </form>
</div>

<script type="text/javascript">
    var tipoSelect = document.getElementById("tipoSelect");
    var spanLavoro = document.getElementById("spanLavoro");

    tipoSelect.addEventListener("change", function(e) {
        if(tipoSelect.value === 'A'){
            spanLavoro.style.display="none";
        }
        else {
            spanLavoro.style.display="unset";
        }
    });
</script>
