package com.anacleto.tomcat;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.logging.Logger;

import org.apache.catalina.Context;
import org.apache.catalina.Engine;
import org.apache.catalina.Host;
import org.apache.catalina.Loader;
import org.apache.catalina.connector.Connector;
import org.apache.catalina.loader.WebappClassLoader;
import org.apache.catalina.startup.Embedded;

import com.anacleto.base.BaseParameters;
import com.anacleto.base.Configuration;
import com.anacleto.base.Constants;
import com.anacleto.base.LoggingParameters;
import com.anacleto.hierarchy.Book;
import com.anacleto.hierarchy.Shelf;
import com.sun.corba.se.impl.orbutil.closure.Constant;


public class EmbeddedTomcat {

	private static String TOMCAT_CD_PATH = "\\tools\\apache-tomcat-5.5.23-embed";
	private static String INDEXDIR_CD_PATH = "\\index";
//	private Logger log;
	
	private String path = null;

	private String indexDir = null;
	private String configDir = null;
	private String contentDir = null;
	private String logDir = null;
	
	private Embedded embedded = null;

	private Host host = null;

	/**
	 * Default Constructor
	 * @throws IOException 
	 *
	 */
	public EmbeddedTomcat(String cdPrefix) throws IOException {
//		Logger log = Logger.getLogger(this.getClass().getName());
		
		this.path = System.getProperty("java.io.tmpdir") + "anacleto/tomcat";
		this.indexDir = cdPrefix + INDEXDIR_CD_PATH;
		
		this.configDir = this.path + "/admin";
		this.contentDir = this.path + "../content";
		this.logDir = this.path + "/logdir";
		
		File pathFile = new File(path);
		if (pathFile.exists())
			pathFile.delete();
		
		File logFile = new File(logDir);
		if (!logFile.exists())
			logFile.mkdirs();
		
		File confFile = new File(configDir);
		if (!confFile.exists())
			confFile.mkdirs();
		
		copyDirectory(new File(cdPrefix + TOMCAT_CD_PATH), new File(path));
	}

	/**
	 * Basic Accessor setting the value of the context path
	 *
	 * @param path - the path
	 */
	public void setPath(String path) {
		this.path = path;
	}

	/**
	 * Basic Accessor returning the value of the context path
	 *
	 * @return - the context path
	 */
	public String getPath() {
		return path;
	}

	/**
	 * This method Starts the Tomcat server.
	 */
	public void startTomcat() throws Exception {
		
		Engine engine = null;
		// Set the home directory
		
		System.setProperty("catalina.home", path);
		System.setProperty("catalina.base", path);
		
		// Create an embedded server
		embedded = new Embedded();
		
		// Create an engine
		engine = embedded.createEngine();
		engine.setDefaultHost("localhost");
		
		//String webappsDir = getPath() + "/webapps";
		// Create a default virtual host
		host = embedded.createHost("localhost", path);
		engine.addChild(host);

		String rootWebappDir = path + "/webapps/anacleto";
		Context context = embedded.createContext("/anacleto", rootWebappDir);
//				contextDir.getCanonicalPath());
		host.addChild(context);
		
		Configuration conf = new Configuration();
		
		BaseParameters params = new BaseParameters();
		params.setConfigDir(configDir);
		params.setIndexDir(this.indexDir);
		
		LoggingParameters logParms = new LoggingParameters();
		logParms.setLogDir(this.logDir);
		
		params.setLogParams(logParms);
		
		conf.init(params);
		Map shelfColl = new HashMap();
		
		Shelf root = new Shelf();
		root.setName("root");
		root.setTitle("Arcanum content");
		shelfColl.put("root", root);
		
		Book b = new Book();
		b.setName("parlamenti_naplo");
		b.setLocation(contentDir);
		b.setContentType("PLUGINCONTENT");
		b.setContentTypeHandler("com.anacleto.parsing.source.PdfPerPageProcessor");
		b.setTitle("Parlamenti Napló");
		b.setParent(root);
		shelfColl.put("parlamenti_naplo", b);
		
		Configuration.setShelfColl(shelfColl);

		// Install the assembled container hierarchy
		embedded.addEngine(engine);

		// Assemble and install a default HTTP connector
		Connector connector = embedded
				.createConnector("localhost", 8080, false);
		embedded.addConnector(connector);
		// Start the embedded server
		embedded.start();
	}

	/**
	 * This method Stops the Tomcat server.
	 */
	public void stopTomcat() throws Exception {
		// Stop the embedded server
		embedded.stop();
	}

	public void copyDirectory(File srcDir, File dstDir) throws IOException {
		if (srcDir.isDirectory()) {
			if (!dstDir.exists()) {
				dstDir.mkdir();
			}
			
			String[] children = srcDir.list();
			for (int i=0; i<children.length; i++) {
				copyDirectory(new File(srcDir, children[i]),
							new File(dstDir, children[i]));
			}
		} else {
			// This method is implemented in e1071 Copying a File
			copyFile(srcDir, dstDir);
		}
	}
	
	void copyFile(File src, File dst) throws IOException {
		InputStream in = new FileInputStream(src);
		OutputStream out = new FileOutputStream(dst);
		
		// Transfer bytes from in to out
		byte[] buf = new byte[1024];
		int len;
		while ((len = in.read(buf)) > 0) {
			out.write(buf, 0, len);
		}
		in.close();
		out.close();
	}
	
	/**
	 * Registers a WAR with the container.
	 *
	 * @param contextPath - the context path under which the
	 *               application will be registered
	 * @param warFile - the URL of the WAR to be
	 * registered.
	 */
	public void registerWAR(String contextPath, URL warFile) throws Exception {

		if (contextPath == null) {
			throw new Exception("Invalid Path : " + contextPath);
		}
		if (contextPath.equals("/")) {
			contextPath = "";
		}
		if (warFile == null) {
			throw new Exception("Invalid WAR : " + warFile);
		}
		Context context =  embedded.createContext(contextPath, warFile.getFile());
		host.addChild(context);
		/*
		if (context != null) {
			throw new Exception("Context " + contextPath + " Already Exists!");
		}
		*/
	}

	/**
	 * Unregisters a WAR from the web server.
	 *
	 * @param contextPath - the context path to be removed
	 */
	public void unregisterWAR(String contextPath) throws Exception {

		Context context = host.map(contextPath);
		if (context != null) {

			embedded.removeContext(context);
		} else {

			throw new Exception("Context does not exist for named path : "
					+ contextPath);
		}
	}

	public static void main(String args[]) {

		try {
			ClassLoader cloader = EmbeddedTomcat.class.getClassLoader();
			URL configURL = cloader.getResource("log4j.properties");
			System.out.println(configURL);
			
			
			if (args.length == 0)
				throw new IllegalArgumentException(
						"usage: .... start | stop [driveletter]");
			
			String driveLetter = null;
			if (args.length == 1){
				File f = new File(configURL.getFile());
				driveLetter = f.getAbsolutePath().substring(0, 2);
				System.out.println(driveLetter);
			}
			
			if (args.length == 2){
				driveLetter = args[1];
			}
			
			EmbeddedTomcat tomcat = new EmbeddedTomcat(driveLetter);
			//tomcat.setPath(drive + ":\\tools\\apache-tomcat-5.5.23-embed");
			
			tomcat.startTomcat();
			
			 URL url =
			 new URL("file:///" + tomcat.getPath() + "/webapps/anacleto.war");
//				 tomcat.registerWAR("/anacleto", url);
			
			Thread.sleep(1000000);

			tomcat.stopTomcat();

			System.exit(0);
		} catch (Exception e) {

			e.printStackTrace();
		}
	}
}