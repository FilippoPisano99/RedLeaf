<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<div class="NavTab">
    <a href="index.jsp?IDPage=1"><h2>< BACK</h2></a>
    <i class="material-icons md-light" style="color:black;" onclick="showAddBox()">add_circle_outline</i>
</div>
<h2>Selezionare un'inventario</h2>

<%
    session.setAttribute("id_sede", request.getParameter("id_sede"));

    if(request.getParameter("action")!=null)
    {
        if(request.getParameter("action").equals("open")){
            if(request.getParameter("descrizione")!=null && request.getParameter("iniziato_il")!=null )
            {
                executeInsert(session,"INSERT INTO inventario (id_inventario, id_sede, descrizione, data_inizio, data_fine) "
                            + "VALUES (NULL, '"+session.getAttribute("id_sede")+"', "
                            + "'"+request.getParameter("descrizione")+"',"
                            + "'"+request.getParameter("iniziato_il")+"', NULL)");
            }
        }else if(request.getParameter("action").equals("close")){
            if(request.getParameter("id_inventario")!=null && request.getParameter("finito_il")!=null )
            {
                executeUpdate(session,"UPDATE inventario SET data_fine = '"+request.getParameter("finito_il")
                        +"' WHERE inventario.id_inventario = "+request.getParameter("id_inventario"));
            }
        }
        else if(request.getParameter("action").equals("delete")){
            executeUpdate(session,"DELETE FROM inventario WHERE id_inventario = "+request.getParameter("id_inventario") );
        }
    }

%>
<div class="sideModifyBox">
    <form class='toolBoxForm' style="display:none"  method="get" action='index.jsp' id="addInv">
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
            <p id="closeIDText">ID:</p><br>
            <p>Chiuso il:</p><input type='date' name='finito_il'><br>
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
            <td class="iconTable"
                <%
                    if(data_fine_string.equals("---"))
                    {
                        %>onClick="setModifyDate('<%= descrizione %>','<%= id_inventario %>','<%= data_inizio %>')" <%
                    }
                %>
                >

                <a href="#">
                    <i class="material-icons md-light" style="color:black;">
                    <%
                        if(data_fine_string.equals("---"))
                        {
                            %>close<%
                        }
                    %>
                    </i>
                </a>
            </td>
            <td class="iconTable">
                <a href="INV/downloadInventario.jsp?descrizione=<%= descrizione %>&id_inventario=<%= id_inventario %>">
                    <i class="material-icons md-light" style="color:black;">file_download</i>
                </a>
            </td>
            <td class="iconTable">
                <a href="index.jsp?IDPage=111&id_sede=<%= session.getAttribute("id_sede") %>&id_inventario=<%= id_inventario %>&inventario_aperto=<%= data_fine_string.equals("---") %>">
                    <i class="material-icons md-light" style="color:black;">open_in_browser</i>
                </a>
            </td>
            <td class="iconTable">
                <!--toggleAskDeleteBox(id_inventario,id_sede,descrizione) -->
                <a onclick="toggleAskDeleteBox(<%= id_inventario %>,<%= session.getAttribute("id_sede") %>,'<%= descrizione %>')">
                    <i class="material-icons md-light" style="color:black;">delete</i>
                </a>
            </td>
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
        <input type="hidden" name="IDPage" value="11">
        <input type="hidden" name="id_sede" value="">
        <input type="hidden" name="id_inventario" value="">
        <input type="submit" id="YesDeleteBtn" value="SI" >
        <input type="button" id="NoDeleteBtn" onclick="toggleAskDeleteBox()" value="NO" >
   </form>
</div>

<script>
    delToggle = 0;
    function setModifyDate(desc,id,min)
    {
        document.getElementById("closeInv").id_inventario.value = id;
        document.getElementById("closeIDText").innerHTML = "Inventario: <strong>" + desc +"<strong>";
        document.getElementById("closeInv").finito_il.min = min;
        //SHOW TAB
        document.getElementById("closeInv").setAttribute("style","");
    }
    function showAddBox()
    {
        //SHOW TAB
        document.getElementById("addInv").setAttribute("style","");
    }
    function toggleAskDeleteBox(id_inventario,id_sede,descrizione)
    {
        if(delToggle%2 == 0){
            document.getElementById("spanNomeInventario").innerHTML=descrizione;
            document.getElementById("AskDeleteBox").style.display="unset";
            document.getElementById("deleteFrom").id_inventario.value=id_inventario;
            document.getElementById("deleteFrom").id_sede.value=id_sede;
            delToggle++;
        }else {
            delToggle++;
            document.getElementById("spanNomeInventario").innerHTML="";
            document.getElementById("AskDeleteBox").style.display="none";
            document.getElementById("deleteFrom").id_inventario.value="";
            document.getElementById("deleteFrom").id_sede.value="";
        }
    }
</script>
