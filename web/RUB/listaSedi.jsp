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
        <th>APRI</th>
    </tr>
  <%
    rs = executeQuery(session,"SELECT * FROM sede");
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
            <td class="iconTable">
                <a href="index.jsp?IDPage=21&id_sede=<%= id_sede %>&tabPage=1">
                    <i class="material-icons md-light" style="color:black;">open_in_browser</i>
                </a>
            </td>
        </tr>
        <%
    }
  %>
</table>
