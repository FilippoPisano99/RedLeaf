<%@page import="java.sql.*"%>
<%
    try{
        session.setAttribute("tabPage",1);
        session.setAttribute("id_sede","");
        session.setAttribute("id_inventario","");
        session.setAttribute("inventario_aperto","");

        response.sendRedirect("index.jsp?IDPage=0");
    }catch(Exception e)
    {
        out.println("ERROR:" + e.getMessage());
        e.printStackTrace();
    }



%>
