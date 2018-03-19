<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
 <div class="NavTab">
    <a href="index.jsp?IDPage=1"><h2>< BACK</h2></a>
</div>
<h2>Selezionare un'inventario</h2>
<%
    session.setAttribute("id_sede", request.getParameter("id_sede"));
    
    if(request.getParameter("action")!=null)
    {
        if(request.getParameter("action").equals("open")){
            if(request.getParameter("descrizione")!=null && request.getParameter("iniziato_il")!=null )
            {
                try
                {
                    stmt = DB.createStatement();
                    stmt.executeUpdate("INSERT INTO inventario (id_inventario, id_sede, descrizione, data_inizio, data_fine) "
                            + "VALUES (NULL, '"+session.getAttribute("id_sede")+"', "
                            + "'"+request.getParameter("descrizione")+"',"
                            + "'"+request.getParameter("iniziato_il")+"', NULL)");
                }catch(Exception e){}
            }
        }else if(request.getParameter("action").equals("close"))
        {
            if(request.getParameter("id_inventario")!=null && request.getParameter("finito_il")!=null )
            {
                try{
                    stmt = DB.createStatement();
                    stmt.executeUpdate("UPDATE inventario SET data_fine = '"+request.getParameter("finito_il")
                            +"' WHERE inventario.id_inventario = "+request.getParameter("id_inventario"));
                }catch(Exception e){}
            }
        }
    }
    
%>
<div class="sideModifyBox">
    <form class='toolBoxForm' method="get" action='index.jsp'>
            <div class="TitleTab">
                <h3>Crea un nuovo inventario</h3>
            </div>
            <input type ="hidden" value="11" name="IDPage">
            <input type ="hidden" value="open" name="action">
            <p>Descrizione:</p><input type='text' name='descrizione'><br>
            <p>Iniziato il:</p><input type='date' name='iniziato_il'><br>
            <input type ="hidden" value="<%= session.getAttribute("id_sede") %>" name="id_sede">

            <input type='submit' class="submitButton" value='Crea inventario'>

    </form>
    <form class='toolBoxForm' style="display:none" method="get" action='index.jsp' id="closeInv">
            <div class="TitleTab">
                <h3>Chiudi inventario</h3>
            </div>
            <input type ="hidden" value="11" name="IDPage">
            <input type ="hidden" value="close" name="action">
            <p>ID:</p><input type='numbger' name='id_inventario'><br>
            <p>Finito il:</p><input type='date' name='finito_il'><br>
            <input type ="hidden" value="<%= session.getAttribute("id_sede") %>" name="id_sede">

            <input type='submit' class="submitButton" value='Chiudi inventario'>

    </form>
</div>
        
<table id="MainTableStyle">
    <tr>
        <th>ID</th>
        <th>DESCRIZIONE</th>
        <th>INIZIATO IL</th>
        <th>FINITO IL</th>
        <th>CHIUDI</th>
        <th>SCARICA</th>
        <th>VISUALIZZA</th>
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
            <td class="iconTable" onClick="setModifyDate('<%= id_inventario %>','<%= data_inizio %>')">
                <a href="#">
                    <i class="material-icons md-light" style="color:black;">close</i>
                </a>
            </td>
            <td class="iconTable">
                <a href="downloadInventario.jsp?descrizione=<%= descrizione %>&id_inventario=<%= id_inventario %>">
                    <i class="material-icons md-light" style="color:black;">file_download</i>
                </a>
            </td>
            <td class="iconTable">
                <a href="index.jsp?IDPage=111&id_sede=<%= session.getAttribute("id_sede") %>&id_inventario=<%= id_inventario %>&inventario_aperto=<%= data_fine_string.equals("---") %>">
                    <i class="material-icons md-light" style="color:black;">open_in_browser</i>
                </a>
            </td>
            
        </tr>
        <%     
    } 
  %>
</table>


<script>
    function setModifyDate(id,min)
    {
        document.getElementById("closeInv").id_inventario.value = id;
        document.getElementById("closeInv").finito_il.min = min;
        //SHOW TAB
        document.getElementById("closeInv").setAttribute("style","");
        
        
    }
</script>