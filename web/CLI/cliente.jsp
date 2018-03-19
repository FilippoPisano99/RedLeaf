<%@page import="java.sql.*"%>
 <div class="NavTab">
    <a href="index.jsp?IDPage=21&id_sede=<%= session.getAttribute("id_sede")%>"><h2>< BACK</h2></a>
</div>

<%!
    public void executeUpdate(HttpSession s , String sql)
    {
        try
        {
            Connection DB = (Connection) s.getAttribute("DB");
            Statement stmt = DB.createStatement();
            stmt.executeUpdate(sql);
        }catch(Exception e)
        {
            
        }
    }
%>


<%

    if(request.getParameter("action")!=null)
    {
        String id_cliente = request.getParameter("id_cliente");
        String opzione = request.getParameter("opzione");
        String new_value = request.getParameter("new_value");
        
        switch(opzione)
        {
            case"0":
                executeUpdate(session,"UPDATE cliente SET telefono="+new_value+" WHERE id_cliente="+id_cliente);
                break;
            case"1":
                break;
            case"2":
                break;
            case"3":
                break;
            case"4":
                break;
                
        }
        
    }

%>

<div class="sideModifyBox">
    <form class='toolBoxForm' method="get" action='index.jsp' id="closeInv">
            <div class="TitleTab">
                <h3>Modifica</h3>
            </div>
            <input type ="hidden" value="211" name="IDPage">
            <input type ="hidden" value="modify" name="action">
            <input type ="hidden" value="<%= request.getParameter("id_cliente") %>" name="id_cliente">
            <p>Campo da modificare:</p>
            <select name="opzione" >
                <option value="" selected disabled hidden>Scegli il campo</option>
                <option value="0">Telefono</option>
                <option value="1">Indirizzo</option>
                <option value="2">Citta</option>
                <option value="3">Email</option>
                <option value="4">P.IVA</option>
            </select>
            
            <p>Nuovo valore:</p>
            <input name="new_value">
            
            <input type='submit' class="submitButton" value='Modifica'>

    </form>
</div>
            
<% 
    stmt = DB.createStatement();    
    rs = stmt.executeQuery("SELECT * FROM cliente WHERE id_cliente = " + request.getParameter("id_cliente") );
    while(rs.next())
    {
        String nome = rs.getString("nome");
        String cognome = rs.getString("cognome");
        String tel = rs.getString("telefono");
        String indirizzo = rs.getString("indirizzo");
        String citta = rs.getString("citta");
        String email = rs.getString("email");
        String p_iva = rs.getString("partita_iva");
        String cf = rs.getString("codice_fiscale");
        %> 
        <div class="identityCardBox">
            <h2><%= nome + " " + cognome %></h2>
            <p>Indirizzo: <%= indirizzo %> ,<%= citta %></p>
            <p>Telefono: <%= tel %></p>
            <p>E-mail: <%= email %></p>
            <p>Partita IVA: <%= p_iva %></p>
            <p>Codice fiscale: <%= cf %></p>
        </div>   
        <%     
    } 
  %>