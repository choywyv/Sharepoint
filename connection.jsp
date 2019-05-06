<%@ page import = "java.io.*, java.net.*, java.util.*, java.util.concurrent.*, javax.net.ssl.*, com.microsoft.aad.adal4j.*, org.json.*" %>

<%@include file="/authentication.jsp" %>

<%!

  String getData (String extraction) throws Exception {

    HttpsURLConnection connection;
    BufferedReader br;
    String s;
    StringBuffer sb;
       
    connection = (HttpsURLConnection) new URL ("https://yourdomain.sharepoint.com/_api/web/lists").openConnection();
    connection.setRequestMethod ("GET");
//    connection.setRequestProperty ("OData-MaxVersion", "4.0");
//    connection.setRequestProperty ("OData-Version", "4.0");
    connection.setRequestProperty ("Accept", "application/json;odata=verbose");
    connection.addRequestProperty ("Authorization", "Bearer " + authenticate ("https://yourdomain.sharepoint.com").getAccessToken ());

    sb = new StringBuffer ();
    br = new BufferedReader (new InputStreamReader (((connection.getResponseCode () >= 200) && (connection.getResponseCode () < 250)) ? connection.getInputStream () : connection.getErrorStream ()));            
    for (; (s = br.readLine ()) != null; ) sb.append (s);
    br.close ();
    connection.disconnect ();

    return sb.toString ();

  } // getData

%>
