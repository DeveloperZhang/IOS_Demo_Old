package servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class DownLoadServlet extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public DownLoadServlet() {
		super();
	}

	/**
	 * Destruction of the servlet. <br>
	 */
	public void destroy() {
		super.destroy(); // Just puts "destroy" string in log
		// Put your code here
	}

	/**
	 * The doGet method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to get.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String path= request.getRealPath("file")+File.separatorChar;
        File file = new File(path);
        if(!file.exists()){//������������·��
            file.mkdirs();//�ʹ���
        }
        File[] fs = file.listFiles();
        for(int i=0; i<fs.length; i++){
        	   System.out.println(fs[i].getAbsolutePath());
        	   if(fs[i].isFile() && !fs[i].getName().contains("DS_Store")){
        	    try{
        	    	FileInputStream hFile = new FileInputStream(fs[i].getAbsolutePath()); 
        	    	
        	        //�õ��ļ���С   
        	        int num=hFile.available(); 
        	        byte data[]=new byte[num]; 
        	        //������   
        	        hFile.read(data);  
        	        response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode(fs[i].getName(), "UTF-8"));
        	        //�õ���ͻ���������������ݵĶ���
        	        OutputStream toClient=response.getOutputStream();  
        	        //�������   
        	        toClient.write(data);  
        	        toClient.flush();  
        	        toClient.close();   
        	        hFile.close();
        	    }catch(Exception e){}
        	    break;
        	   }
        }
	}

	/**
	 * The doPost method of the servlet. <br>
	 *
	 * This method is called when a form has its tag value method equals to post.
	 * 
	 * @param request the request send by the client to the server
	 * @param response the response send by the server to the client
	 * @throws ServletException if an error occurred
	 * @throws IOException if an error occurred
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		this.doGet(request, response);
	}

	/**
	 * Initialization of the servlet. <br>
	 *
	 * @throws ServletException if an error occurs
	 */
	public void init() throws ServletException {
		// Put your code here
	}

}
