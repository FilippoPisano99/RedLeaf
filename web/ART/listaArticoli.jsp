<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="java.sql.*"%>
 <div class="NavTab">
    <a href="index.jsp?IDPage=4"><h2>< BACK</h2></a>
</div>
<h2>Selezionare un articolo</h2>
<%
    session.setAttribute("tabPage",Integer.parseInt(request.getParameter("tabPage")));
    session.setAttribute("id_sede", request.getParameter("id_sede"));
/*
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
        else if(request.getParameter("action").equals("delete"))
        {
            executeUpdate(session,"DELETE FROM articolo WHERE id_articolo = " +request.getParameter("id_articolo"));
        }
    }
*/
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
        <th>NOME</th>
        <th>BARCODE</th>
        <th>FORNITORE</th>
        <th>
        <%
            if(getTabPage( session ) > 1){
                out.println("<a href='index.jsp?IDPage=41&id_sede=3&tabPage="+(getTabPage( session )-1)+"'>");
                out.println("<i class=\"material-icons\">first_page</i>");
                out.println("</a>");
            }

        %>
        </th>
        <th>

        <%
        try{

            String countArticoliSql = "SELECT COUNT(*) as 'N'"+
            "FROM (articolo a INNER JOIN rubrica r ON r.id_rubrica = a.id_rubrica) "+
        	"INNER JOIN sede s "+
        	"ON s.id_sede = r.id_sede "+
        	"WHERE s.id_sede = " + session.getAttribute("id_sede");

            int count = 0;

            rs=executeQuery(session,countArticoliSql);
            while (rs.next()) {
                count = rs.getInt("N");
            }

            int diff = getDiff(count,session);

            if(diff > 15)
            {
                out.println("<a href='index.jsp?IDPage=41&id_sede=3&tabPage="+(getTabPage( session )+1)+"'>");
                out.println("<i class=\"material-icons\">last_page</i>");
                out.println("</a>");
            }

        }catch (Exception e) {
            System.out.println(e.getMessage());
        }
        %>
        </th>
    </tr>
  <%
    rs = executeQuery(session,"SELECT a.id_articolo, a.nome , a.barcode , r.id_rubrica , r.nome AS \"NomeFornitore\", r.cognome AS \"CognomeFornitore\" "+
                        "FROM (articolo a INNER JOIN rubrica r "+
	                          "ON r.id_rubrica = a.id_rubrica) "+
                                "INNER JOIN sede s "+
    		                         "ON s.id_sede = r.id_sede "+
                        "WHERE s.id_sede =" + session.getAttribute("id_sede")+
                        " LIMIT "+((((int) session.getAttribute("tabPage"))-1)*15)+",15" );
    while(rs.next())
    {
        String id_articolo = rs.getString("id_articolo");
        String nome = rs.getString("nome");
        String barcode = rs.getString("barcode");
        String NomeFornitore = rs.getString("NomeFornitore");
        String CognomeFornitore = rs.getString("CognomeFornitore");
        String id_rubrica = rs.getString("id_rubrica");
        %>
        <tr>
            <td><%= nome %></td>
            <td><%= barcode %></td>
            <td><%= NomeFornitore + " " + CognomeFornitore %></td>
            <td class="iconTable">
                <a href="index.jsp?IDPage=411&id_articolo=<%=id_articolo%>">
                    <i class="material-icons md-light" style="color:black;">open_in_browser</i>
                </a>
            </td>
            <td class="iconTable">
                <a href="index.jsp?IDPage=41&id_articolo=<%=id_articolo%>&id_sede=<%=request.getParameter("id_sede")%>&action=delete">
                    <i class="material-icons md-light" style="color:black;">delete</i>
                </a>
            </td>

        </tr>
        <%
    }
  %>
</table>
