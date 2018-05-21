<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
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

    public int getTabPage( HttpSession session )
    {
        return ( (int) session.getAttribute("tabPage") );
    }
    public int getNextIdxPage( HttpSession session )
    {
        return ( ( ( getTabPage( session ) )-1 )*15 );
    }
    public int getDiff(int count, HttpSession session )
    {
        return count-getNextIdxPage( session );
    }

    public String generaStringaRandom()
    {
        String out ="";
		String AlphaSet = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";
        Random rnd = new Random();
        for (int i = 0 ; i<60; i++ ) {
        	char ch = AlphaSet.charAt( rnd.nextInt( AlphaSet.length() ) );
            out += ch ;
        }
        return out;


    }


%>
