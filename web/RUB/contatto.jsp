<%@page import="java.sql.*"%>
 <div class="NavTab">
    <a href="index.jsp?IDPage=21&id_sede=<%= session.getAttribute("id_sede")%>"><h2>< BACK</h2></a>
</div>

<%

    if(request.getParameter("action")!=null)
    {
        if(request.getParameter("action").equals("modify"))
        {
            String id_rubrica = request.getParameter("id_rubrica");
            String opzione = request.getParameter("opzione");
            String new_value = request.getParameter("new_value");

            if(!opzione.equals("")){
                executeUpdate(session,"UPDATE rubrica SET "+opzione+"='"+new_value+"' WHERE id_rubrica="+id_rubrica);
            }
        }
        if(request.getParameter("action").equals("add"))
        {
            String id_rubrica = request.getParameter("id_rubrica");
            String nome = request.getParameter("nome");
            String barcode = request.getParameter("barcode");
            String costo = request.getParameter("costo");

            executeInsert(session,"INSERT INTO articolo VALUES (NULL,"+id_rubrica+",'"+nome+"', '"+barcode+"', "+costo+" )");

        }

    }

%>


<div class="sideModifyBox">
<%
    rs = executeQuery(session,"SELECT tipo FROM rubrica WHERE id_rubrica = " + request.getParameter("id_rubrica") );
    while (rs.next())
    {
        if(rs.getString("tipo").equals("F"))
        {
            %>
            <form class='toolBoxForm' method="get" action='index.jsp' id="closeInv">
                <div class="TitleTab">
                    <h3>Aggiungi un articolo</h3>
                </div>
                <input type ="hidden" value="211" name="IDPage">
                <input type ="hidden" value="add" name="action">
                <input type ="hidden" value="<%= request.getParameter("id_rubrica") %>" name="id_rubrica">
                <p>Nome:</p>
                <input type="text" name="nome">

                <p>Barcode:</p>
                <input type="text" name="barcode">

                <p>Costo:</p>
                <input type="number" min="0" step="0.01" name="costo">

                <input type='submit' class="submitButton" value='Aggiungi'>
            </form>
            <%
        }
        break;
    }
%>

    <form class='toolBoxForm' method="get" action='index.jsp' id="closeInv">
            <div class="TitleTab">
                <h3>Modifica</h3>
            </div>
            <input type ="hidden" value="211" name="IDPage">
            <input type ="hidden" value="modify" name="action">
            <input type ="hidden" value="<%= request.getParameter("id_rubrica") %>" name="id_rubrica">
            <p>Campo da modificare:</p>
            <select name="opzione" >
                <option value="" selected disabled hidden>Scegli il campo</option>
                <option value="telefono">Telefono</option>
                <option value="indirizzo">Indirizzo</option>
                <option value="citta">Citta</option>
                <option value="email">Email</option>
                <option value="partita_iva">P.IVA</option>
            </select>

            <p>Nuovo valore:</p>
            <input name="new_value">

            <input type='submit' class="submitButton" value='Modifica'>

    </form>
</div>

<%

    rs = executeQuery(session,"SELECT * FROM rubrica WHERE id_rubrica = " + request.getParameter("id_rubrica") );
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
        String tipo = rs.getString("tipo");
        %>
        <div class="identityCardBox">
            <h2><%= nome + " " + cognome %></h2>
            <strong><%= tipo.equals("F")? "FORNITORE" : "CLIENTE" %></strong>
            <p>Indirizzo: <%= indirizzo %> ,<%= citta %></p>
            <p>Telefono: <%= tel %></p>
            <p>E-mail: <a href="mailto:<%= email %>"><%= email %></a></p>
            <p>Partita IVA: <%= p_iva %></p>
            <p>Codice fiscale: <%= cf %></p>
        </div>
        <%

        break;
    }
  %>
