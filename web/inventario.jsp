<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
 <div class="NavTab">
    <a href="index.jsp?IDPage=11&id_sede=<%= request.getParameter("id_sede") %>"><h2>< BACK</h2></a>
</div>
 
<h2>Prodotti :</h2>

<%
    session.setAttribute("inventario_aperto", request.getParameter("inventario_aperto") );
    session.setAttribute("id_inventario",request.getParameter("id_inventario"));
    if(request.getParameter("nome")!=null && 
            request.getParameter("barcode")!=null && 
            request.getParameter("qta")!=null && 
            request.getParameter("costo")!=null )
    {
        String nome = request.getParameter("nome")+"";
        String barcode = request.getParameter("barcode")+"";
        String qta = request.getParameter("qta")+"";
        String costo = request.getParameter("costo")+"";
        
        try
        {
            stmt = DB.createStatement();
            stmt.executeUpdate("INSERT INTO prodotto (id_prodotto, nome, qta, barcode, id_inventario, costo) "
                    + "VALUES (NULL,\""+nome+"\", '"+qta+"', '"+barcode+"', '"+session.getAttribute("id_inventario")+"', '"+costo+"')");
        }catch(Exception e)
        {
        }
        
    }
    if( session.getAttribute("inventario_aperto")!=null && session.getAttribute("inventario_aperto").equals("true"))
    {
%>
    <form class='newIstanceBoxForm' method="get" 
          action='index.jsp'>

        <div class="TitleTab">
            <h3>Aggiungi un prodotto</h3>
        </div>
        <input type ="hidden" value="111" name="IDPage">
        <p>Nome:</p><input type='text' name='nome'><br>
        <p>Barcode:</p><input type='text' name='barcode'><br>
        <p>Qta:</p><input type='number' name='qta' min='0'><br>
        <p>Costo:</p><input type='number' name='costo' min='0' step="0.01"><br>
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
    rs = stmt.executeQuery("SELECT * FROM prodotto WHERE id_inventario = " + id_inventario);
    while(rs.next())
    {
        String id_prodotto = rs.getString("id_prodotto");
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
