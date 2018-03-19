<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
 <div class="NavTab">
    <a href="index.jsp?IDPage=2"><h2>< BACK</h2></a>
</div>
<h2>Selezionare un cliente</h2>
<%
    session.setAttribute("id_sede", request.getParameter("id_sede"));
    /*
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
    }*/
    
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
            <input type='hidden' name='id_inventario'>
            <p id="closeIDText">ID:</p>
            <p>Finito il:</p><input type='date' name='finito_il'><br>
            <input type ="hidden" value="<%= session.getAttribute("id_sede") %>" name="id_sede">

            <input type='submit' class="submitButton" value='Chiudi inventario'>

    </form>
</div>
        
<table id="MainTableStyle">
    <tr>
        <th>ID</th>
        <th>NOMINATIVO</th>
        <th>TELEFONO</th>
        <th>P.IVA</th>
        <th>VISUALIZZA</th>
    </tr>
  <% 
    stmt = DB.createStatement();    
    rs = stmt.executeQuery("SELECT * FROM cliente WHERE id_sede = " + session.getAttribute("id_sede") );
    while(rs.next())
    {
        String id_cliente = rs.getString("id_cliente");
        String nome = rs.getString("nome");
        String cognome = rs.getString("cognome");
        String tel = rs.getString("telefono");
        String p_iva = rs.getString("partita_iva");
        %> 
        <tr>
            <td><%= id_cliente %></td>
            <td><%= nome +" " + cognome %></td>
            <td><%= tel %></td>
            <td><%= p_iva %></td>
            <td class="iconTable">
                <a href="index.jsp?IDPage=211&id_cliente=<%=id_cliente%>">
                    <i class="material-icons md-light" style="color:black;">open_in_browser</i>
                </a>
            </td>
            
        </tr>
        <%     
    } 
  %>
</table>