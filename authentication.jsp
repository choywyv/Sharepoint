<%@ page import = "java.io.*, java.net.*, java.util.*, java.util.concurrent.*, java.security.*, java.security.cert.*, javax.net.ssl.*, com.microsoft.aad.adal4j.*, org.json.*" %>

<%!

  static final String keyStorePath = "path_to_key_and_pfx";

  AuthenticationResult authenticate (String baseURL) throws Exception {

    AuthenticationResult result = null;
    ExecutorService service = null;
    FileInputStream fis;


    fis = new FileInputStream (keyStorePath + "EFM.cer");
    service = Executors.newFixedThreadPool (1);
    result = new AuthenticationContext ("https://login.microsoftonline.com/yourtenant/oauth2", false, service).acquireToken (
                 baseURL,
                 AsymmetricKeyCredential.create ("you_app_id", getPrivateKey ("your.pfx", "password_used_to_create_pfx".toCharArray(), "myalias"), (X509Certificate) CertificateFactory.getInstance("X.509").generateCertificate (fis)),
                 null).get();

    service.shutdown();
    fis.close ();

    return result;

  } // authenticate


  PrivateKey getPrivateKey (String keyfile, char[] keyfilePass, String alias) throws Exception {

    KeyStore ks;

    ks = KeyStore.getInstance (KeyStore.getDefaultType());
    ks.load (new FileInputStream (keyStorePath + keyfile), keyfilePass); 
    return ks.containsAlias (alias)? (PrivateKey) ks.getKey (alias, keyfilePass) : null;

  } // getPrivateKey

%>
