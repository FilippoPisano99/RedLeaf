<%@page import="java.sql.*"%>
<%@page import="javax.servlet.http.*"%>
<%!

    public boolean isNull(Object o)
    {
        return (o == null);
    }

    public boolean isAllFieldFilled(String fields[])
    {
        boolean output = true;
        for(int i = 0; i<fields.length && output; i++ )
        {
            output = !isNull(fields[i]);
        }

        return output;
    }

    public boolean isPhoneNumber(String s)
    {
        return s.matches("[0-9]{10}");
    }

    public boolean containsNumbers(String s)
    {   
        return s.matches(".*\\d.*");
    }

    public boolean isCF(String s)
    {
        return s.matches("[A-Z]{6}[0-9]{2}[A-Z][0-9]{2}[A-Z][0-9]{3}[A-Z]");
    }

    public boolean executeInsert(HttpSession session, String sql)
    {
        boolean output = true;
        try
        {
            Connection DB = (Connection) session.getAttribute("DB");
            Statement stmt = DB.createStatement();
            stmt.executeUpdate(sql);
        }
        catch(Exception e){output = false;}

        return output;
    }

    public boolean executeUpdate(HttpSession session, String sql)
    {
        boolean output = true;
        try
        {
            Connection DB = (Connection) session.getAttribute("DB");
            Statement stmt = DB.createStatement();
            stmt.executeUpdate(sql);
        }
        catch(Exception e){output = false;}

        return output;
    }

    public ResultSet executeQuery(HttpSession session, String sql)
    {
        ResultSet output;
        try
        {
            Connection DB = (Connection) session.getAttribute("DB");
            Statement stmt = DB.createStatement();
            output = stmt.executeQuery(sql);
        }
        catch(Exception e){output = null;}

        return output;
    }

%>