<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.*"%>
 <div class="NavTab">
    <a href="index.jsp?IDPage=2"><h2>< BACK</h2></a>
</div>
<h2>Selezionare un contatto</h2>
<%
    session.setAttribute("id_sede", request.getParameter("id_sede"));
    
    if(request.getParameter("action")!=null)
    {
        if(request.getParameter("action").equals("create")){
            String fields[] = {
                request.getParameter("nome"),request.getParameter("cognome"),
                request.getParameter("indirizzo"),request.getParameter("telefono"),
                request.getParameter("email"),request.getParameter("citta"),
                request.getParameter("cf"),request.getParameter("piva"),request.getParameter("tipo")};
            
            
            if( isAllFieldFilled(fields) )
            {
                if( (!containsNumbers(request.getParameter("nome"))) && (!containsNumbers(request.getParameter("cognome"))) 
                        && (!containsNumbers(request.getParameter("citta"))) && isPhoneNumber(request.getParameter("telefono")) 
                        && isCF(request.getParameter("cf")))
                {
                    executeInsert(session, "INSERT INTO rubrica "
                            + "(id_rubrica, id_sede, nome, cognome, indirizzo, citta, partita_iva, codice_fiscale, telefono, email,tipo) "
                            + "VALUES (NULL, "
                            + "'"+session.getAttribute("id_sede")+"', "
                            + "'"+request.getParameter("nome")+"', "
                            + "'"+request.getParameter("cognome")+"',"
                            + " '"+request.getParameter("indirizzo")+"',"
                            + " '"+request.getParameter("citta")+"', "
                            + " '"+request.getParameter("piva")+"', "
                            + " '"+request.getParameter("cf")+"', "
                            + " '"+request.getParameter("telefono")+"', "
                            + " '"+request.getParameter("email")+"', "
                            + " '"+request.getParameter("tipo")+"')");
                }
            }
        }
    }
    
%>
<div class="sideModifyBox">
    <form class='toolBoxForm' method="get" action='index.jsp'>
            <div class="TitleTab">
                <h3>Aggiungi un contatto</h3>
            </div>
            <input type ="hidden" value="21" name="IDPage">
            <input type ="hidden" value="create" name="action">
            <input type ="hidden" value="<%= session.getAttribute("id_sede") %>" name="id_sede">
            
            <p>Nome:</p><input type='text' name='nome'><br>
            <p>Cognome:</p><input type='text' name='cognome'><br>
            <p>Indirizzo:</p><input type='text' name='indirizzo'><br>
            <p>Telefono:</p><input type='text' name='telefono'><br>
            <p>E-mail:</p><input type='email' name='email'><br>
            <p>Citt&agrave;:</p><input type='text' name='citta'><br>
            <p>Codice Fiscale:</p><input type='text' name='cf'><br>
            <p>P.IVA:</p><input type='text' name='piva'><br>
            <p>Tipo:</p><br>
            <input type="radio" name="tipo" value="C" checked="checked"><p>Cliente</p><br>
            <input type="radio" name="tipo" value="F"><p>Fornitore</p>
            
            <input type='submit' class="submitButton" value='Aggiungi'>

    </form>
</div>
        
<table id="MainTableStyle">
    <tr>
        <th>NOMINATIVO</th>
        <th>TELEFONO</th>
        <th>P.IVA</th>
        <th>VISUALIZZA</th>
    </tr>
  <% 
    stmt = DB.createStatement();    
    rs = stmt.executeQuery("SELECT * FROM rubrica WHERE id_sede = " + session.getAttribute("id_sede") );
    while(rs.next())
    {
        String id_rubrica = rs.getString("id_rubrica");
        String nome = rs.getString("nome");
        String cognome = rs.getString("cognome");
        String tel = rs.getString("telefono");
        String p_iva = rs.getString("partita_iva");
        %> 
        <tr>
            <td><%= nome +" " + cognome %></td>
            <td><%= tel %></td>
            <td><%= p_iva %></td>
            <td class="iconTable">
                <a href="index.jsp?IDPage=211&id_rubrica=<%=id_rubrica%>">
                    <i class="material-icons md-light" style="color:black;">open_in_browser</i>
                </a>
            </td>
            
        </tr>
        <%     
    } 
  %>
</table>