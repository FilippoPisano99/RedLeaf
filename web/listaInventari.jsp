<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
 <div class="NavTab">
    <a href="index.jsp?IDPage=1"><h2>< BACK</h2></a>
</div>
<h2>Selezionare un'inventario</h2>
<%
    session.setAttribute("id_sede", request.getParameter("id_sede"));
    
    if(request.getParameter("descrizione")!=null && 
            request.getParameter("iniziato_il")!=null )
    {
        try
        {
            stmt = DB.createStatement();
            stmt.executeUpdate("INSERT INTO inventario (id_inventario, id_sede, descrizione, data_inizio, data_fine) "
                    + "VALUES (NULL, '"+session.getAttribute("id_sede")+"', "
                    + "'"+request.getParameter("descrizione")+"',"
                    + "'"+request.getParameter("iniziato_il")+"', NULL)");
        }catch(Exception e)
        {
        }
    }
%>
<form class='newIstanceBoxForm' method="get" action='index.jsp'>
        <div class="TitleTab">
            <h3>Crea un nuovo inventario</h3>
        </div>
        <input type ="hidden" value="11" name="IDPage">
        <p>Descrizione:</p><input type='text' name='descrizione'><br>
        <p>Iniziato il:</p><input type='date' name='iniziato_il'><br>
        <input type ="hidden" value="<%= session.getAttribute("id_sede") %>" name="id_sede">

        <input type='submit' class="submitButton" value='Crea inventario'>

</form>
        
<table id="MainTableStyle">
    <tr>
        <th>ID</th>
        <th>DESCRIZIONE</th>
        <th>INIZIATO IL</th>
        <th>FINITO IL</th>
        <th></th>
    </tr>
  <% 
    stmt = DB.createStatement();    
    rs = stmt.executeQuery("SELECT * FROM inventario WHERE id_sede = " + session.getAttribute("id_sede") );
    while(rs.next())
    {
        String id_inventario = rs.getString("id_inventario");
        String descrizione = rs.getString("descrizione");
        Date data_inizio = rs.getDate("data_inizio");
        Date data_fine = rs.getDate("data_fine");
        
        SimpleDateFormat formatoData = new SimpleDateFormat("dd/MM/yyyy");
        String data_inizio_string = formatoData.format(data_inizio);
        String data_fine_string = "---";
        if(data_fine != null)
        {
            data_fine_string = formatoData.format(data_fine);
        }
         
        %> 
        <tr>
            <td><%= id_inventario %></td>
            <td><%= descrizione %></td>
            <td><%= data_inizio_string %></td>
            <td><%= data_fine_string %></td>
            <td>
                <a href="index.jsp?IDPage=111&id_sede=<%= session.getAttribute("id_sede") %>&id_inventario=<%= id_inventario %>&inventario_aperto=<%= data_fine_string.equals("---") %>">APRI</a>
            </td>
        </tr>
        <%     
    } 
  %>
</table>