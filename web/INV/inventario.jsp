<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<div class="NavTab">
    <a href="index.jsp?IDPage=11&id_sede=<%= request.getParameter("id_sede") %>"><h2>< BACK</h2></a>
</div>
 
<h2>Prodotti :</h2>

<%
    session.setAttribute("inventario_aperto", request.getParameter("inventario_aperto") );
    session.setAttribute("id_inventario",request.getParameter("id_inventario"));
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
    if( session.getAttribute("inventario_aperto")!=null && session.getAttribute("inventario_aperto").equals("true"))
    {
%>
    <form class='toolBoxForm' method="get" action='index.jsp'>
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
    stmt = DB.createStatement();
    rs = stmt.executeQuery("SELECT * FROM articolo a, dettaglioInventario dett "
            + "WHERE a.id_articolo = dett.id_articolo "
            + "AND dett.id_inventario = " + id_inventario);
    while(rs.next())
    {
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
        </tr>
        <%     
    } 
  %>
</table>
