<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<div class="NavTab">
    <a href="index.jsp?IDPage=11&id_sede=<%= request.getParameter("id_sede") %>"><h2>< BACK</h2></a>
    <%
    if(request.getParameter("inventario_aperto") !=null && request.getParameter("inventario_aperto").equals("true"))
    {
        out.println("<i class=\"material-icons md-light\" style=\"color:black;\" onclick=\"showAddBox()\">add_circle_outline</i>");
    }
    %>
</div>

<h2>Prodotti :</h2>

<%
    session.setAttribute("inventario_aperto", request.getParameter("inventario_aperto") );
    session.setAttribute("id_inventario",request.getParameter("id_inventario"));

    if(request.getParameter("action")!=null)
    {
        if(request.getParameter("action").equals("add")){
            if(request.getParameter("id_articolo")!=null && request.getParameter("qta")!=null)
            {
                String id_articolo = request.getParameter("id_articolo");
                String qta = request.getParameter("qta");

                rs =  executeQuery(session,"SELECT * FROM dettaglioInventario WHERE id_inventario = " + session.getAttribute("id_inventario")
                        + " AND id_articolo="+id_articolo);
                boolean hadArticle = false;
                while(rs.next())
                {
                    int Oldqta = rs.getInt("qta");
                    int newqta = Oldqta + Integer.parseInt(qta);
                    executeUpdate(session,"UPDATE dettaglioInventario SET qta = "+newqta +" WHERE id_articolo="+id_articolo);
                    hadArticle = true;
                    break;
                }

                if(!hadArticle)
                {
                    executeInsert(session,"INSERT INTO dettaglioInventario (id_dettaglioInventario, id_inventario, id_articolo , qta) "
                            + "VALUES (NULL,\""+session.getAttribute("id_inventario")+"\",\""+id_articolo+"\", '"+qta+"' )");
                }

            }
        }
        else if(request.getParameter("action").equals("delete")){
            executeUpdate(session,"DELETE FROM dettaglioInventario WHERE id_dettaglioInventario = "+request.getParameter("id_dettaglioInventario") );
        }
    }


    if( session.getAttribute("inventario_aperto")!=null && session.getAttribute("inventario_aperto").equals("true"))
    {
%>
    <form class='toolBoxForm' id="addArt"  style="display:none;" method="get" action='index.jsp'>
        <input type="hidden" name="action" value="add">
        <div class="TitleTab">
            <h3>Aggiungi un prodotto</h3>
        </div>
        <input type ="hidden" value="111" name="IDPage">
        <p>Seleziona un prodotto:</p>
        <select name="id_articolo">
            <%
            //<option></option>
                rs = executeQuery(session, "SELECT a.id_articolo,a.nome FROM articolo a, rubrica r "
                        + "WHERE r.tipo='F' AND "
                        + "r.id_sede = "+session.getAttribute("id_sede"));
                while(rs.next())
                {
                    %><option value="<%= rs.getString("id_articolo") %>"><%= rs.getString("nome") %></option><%
                }
            %>
        </select>
        <br>
        <p>Qta:</p><input type='number' name='qta' min='0'><br>
        <input type ="hidden" value="<%= session.getAttribute("id_sede") %>" name="id_sede">
        <input type ="hidden" value="true" name="inventario_aperto">
        <input type ="hidden" value="<%= session.getAttribute("id_inventario") %>" name="id_inventario">

        <input type='submit' class="submitButton" value='Aggiungi'>

    </form>
<%
    }

%>
<table id="MainTableStyle">
    <tr>
        <th>NOME</th>
        <th>BARCODE</th>
        <th>QTA</th>
        <th>COSTO</th>
    </tr>
  <%
    String id_inventario = request.getParameter("id_inventario");
    rs = executeQuery(session,"SELECT * FROM articolo a, dettaglioInventario dett "
            + "WHERE a.id_articolo = dett.id_articolo "
            + "AND dett.id_inventario = " + id_inventario);
    while(rs.next())
    {
        String id_dettaglioInventario = rs.getString("id_dettaglioInventario");
        String nome = rs.getString("nome");
        String barcode = rs.getString("barcode");
        String qta = rs.getString("qta");
        String costo = rs.getString("costo");
        %>
        <tr>
            <td><%= nome %></td>
            <td><%= barcode %></td>
            <td><%= qta %></td>
            <td><%= costo %></td>
            <%
            if(session.getAttribute("inventario_aperto")!=null && session.getAttribute("inventario_aperto").equals("true"))
            {
                out.println("<td class='iconTable'>");
                out.println("<a onclick=\"toggleAskDeleteBox("+id_inventario +","+session.getAttribute("id_sede")+","+id_dettaglioInventario+",'"+nome+"')\">");
                out.println("<i class='material-icons md-light' style='color:black;'>delete</i>");
                out.println("</a>");
                out.println("</td>");
            }
            %>
        </tr>
        <%
    }
  %>
</table>

<div id="AskDeleteBox">
   <div class="TitleTab">
      <h3>Vuoi cancellare l'inventario</h3>
   </div>
   <p>Vuoi cancellare l'inventario :<br><span id="spanNomeInventario"></span></p>
   <br>
   <form method="GET" id="deleteFrom" action="index.jsp">
        <input type="hidden" name="action" value="delete">
        <input type="hidden" name="IDPage" value="111">
        <input type="hidden" name="id_sede" value="">
        <input type="hidden" name="id_inventario" value="">
        <input type="hidden" name="id_dettaglioInventario" value="">
        <input  type="hidden" name="inventario_aperto" value="<%= session.getAttribute("inventario_aperto")%>">
        <input type="submit" id="YesDeleteBtn" value="SI" >
        <input type="button" id="NoDeleteBtn" onclick="toggleAskDeleteBox()" value="NO" >
   </form>
</div>

<script>
    delToggle=0;
    function showAddBox()
    {
        //SHOW TAB
        document.getElementById("addArt").setAttribute("style","");
    }
    function toggleAskDeleteBox(id_inventario,id_sede,id_dettaglioInventario,nome)
    {
        if(delToggle%2 == 0){
            document.getElementById("spanNomeInventario").innerHTML=nome;
            document.getElementById("AskDeleteBox").style.display="unset";
            document.getElementById("deleteFrom").id_inventario.value=id_inventario;
            document.getElementById("deleteFrom").id_sede.value=id_sede;
            document.getElementById("deleteFrom").id_dettaglioInventario.value=id_dettaglioInventario;
            delToggle++;
        }else {
            delToggle++;
            document.getElementById("spanNomeInventario").innerHTML="";
            document.getElementById("AskDeleteBox").style.display="none";
            document.getElementById("deleteFrom").id_inventario.value="";
            document.getElementById("deleteFrom").id_sede.value="";
            document.getElementById("deleteFrom").id_dettaglioInventario.value="";
        }
    }
</script>
