<%@page import="java.sql.*"%>
<%
    try{
        if(request.getParameter("id_inventario")!=null && request.getParameter("descrizione")!=null)
        {
            String csvFileContent ="nome;barcode;qta;costo;\n";
            Statement stmt = ((Connection)session.getAttribute("DB")).createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM prodotto WHERE id_inventario = " + request.getParameter("id_inventario"));
            while(rs.next())
            {
                String nome = rs.getString("nome");
                String barcode = rs.getString("barcode");
                String qta = rs.getString("qta");
                String costo = rs.getString("costo");
                csvFileContent += nome +";"+barcode +";"+qta +";"+costo +";\n";
            } 
            response.setContentType("APPLICATION/OCTET-STREAM");   
            response.setHeader("Content-Disposition","attachment; filename=\""+request.getParameter("descrizione").trim()+".csv\"");   
            response.getWriter().write(csvFileContent.trim());
        }
    }catch(Exception e)
    {
        out.println("ERROR:" + e.getMessage());
        e.printStackTrace();
    }
    
    

%>