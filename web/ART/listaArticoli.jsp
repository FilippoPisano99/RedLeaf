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
    if(request.getParameter("action")!=null)
    {
        if(request.getParameter("action").equals("add")){
            String nome = request.getParameter("nome");
            String barcode = request.getParameter("barcode");
            String costo = request.getParameter("costo");
            String id_rubrica = request.getParameter("id_rubrica");

            executeInsert(session,"INSERT INTO articolo VALUES (NULL,"+id_rubrica+",'"+nome+"', '"+barcode+"', "+costo+" )");
        }
        else if(request.getParameter("action").equals("delete"))
        {
            executeUpdate(session,"DELETE FROM articolo WHERE id_articolo = " +request.getParameter("id_articolo"));
        }
    }

%>
<div class="sideModifyBox">
    <form class='toolBoxForm' method="get" action='index.jsp'>
            <div class="TitleTab">
                <h3>Aggiungi un articolo</h3>
            </div>
            <input type ="hidden" value="41" name="IDPage">
            <input type ="hidden" value="add" name="action">
            <input type="hidden" name="tabPage" value="1">
            <input type ="hidden" value="<%= session.getAttribute("id_sede") %>" name="id_sede">

            <p>Nome:</p><input type='text' name='nome'><br>
            <p>Barcode:</p><input type='text' name='barcode'><br>
            <p>Costo:</p><input type="number" min="0" step="0.01" name="costo"><br>

            <select  name="id_rubrica">
                <%
                    rs = executeQuery(session,"SELECT r.id_rubrica,r.nome,r.cognome "
                        +"FROM rubrica r "
                        +"WHERE r.id_sede = " + session.getAttribute("id_sede") + " "
                        +"AND r.tipo = 'F'");

                    while(rs.next())
                    {
                        out.println("<option value='"+rs.getString("id_rubrica")+"'>"+
                            rs.getString("nome")+" "+rs.getString("cognome")+
                        "</option>");
                    }
                %>

            </select>


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
            <td><span class="barcode"><%= barcode %> </span></td>
            <td><%= NomeFornitore + " " + CognomeFornitore %></td>
            <td class="iconTable">
                <a href="index.jsp?IDPage=411&tabPage=1&id_articolo=<%=id_articolo%>&id_sede=<%=request.getParameter("id_sede")%>">
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
