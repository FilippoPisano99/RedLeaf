<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<div class="NavTab">
    <a href="index.jsp?IDPage=0"><h2>< BACK</h2></a>
</div>
<h2>Selezionare una sede</h2>
<table id="MainTableStyle">
    <tr>
        <th>ID</th>
        <th>NOME</th>
        <th>INDIRIZZO</th>
        <th>APERTO DAL</th>
        <th></th>
    </tr>
  <% 
    Statement stmt = DB.createStatement();
    ResultSet rs =stmt.executeQuery("SELECT * FROM sede");
    while(rs.next())
    {
        String id_sede = rs.getString("id_sede");
        String nome = rs.getString("nome");
        String indirizzo = rs.getString("indirizzo");
        Date aperto_dal = rs.getDate("aperto_dal");
        SimpleDateFormat formatoData = new SimpleDateFormat("dd/MM/yyyy");
        String date = formatoData.format(aperto_dal);
        %> 
        <tr>
            <td><%= id_sede %></td>
            <td><%= nome %></td>
            <td><%= indirizzo %></td>
            <td><%= date %></td>
            <td>
                <a href="index.jsp?IDPage=11&id_sede=<%= id_sede %>">APRI</a>
            </td>
        </tr>
        <%     
    } 
  %>
</table>
