package servlets;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.FileItemFactory;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;


public class UploadServlet1 extends HttpServlet {

	/**
	 * Constructor of the object.
	 */
	public UploadServlet1() {
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
//		System.out.println("123456231231233123");
		//判断提交过来的表单是否为文件上传菜单 
        boolean isMultipart= ServletFileUpload.isMultipartContent(request);
        if(isMultipart){
            //构造一个文件上传处理对象
            FileItemFactory factory = new DiskFileItemFactory();
            ServletFileUpload upload = new ServletFileUpload(factory);
            Iterator    items;
            try{
                //解析表单中提交的所有文件内容
                items=upload.parseRequest(request).iterator();
                while(items.hasNext()){
                    FileItem item = (FileItem) items.next();
                    if(!item.isFormField()){
                        //取出上传文件的文件名称
                        String name = item.getName();
                        //取得上传文件以后的存储路径
                        String fileName=name.substring(name.lastIndexOf('\\')+1,name.length());
                        //上传文件以后的存储路径
                        String path= request.getRealPath("file")+File.separatorChar;
                        File file = new File(path);
                        if(!file.exists()){//如果不存在这个路径
                            file.mkdirs();//就创建
                        }
                        //上传文件
                        File uploaderFile = new File(path,fileName);
                        item.write(uploaderFile);
                        //打印上传成功信息
//                        response.setContentType("text/html");
//                        response.setCharacterEncoding("GB2312");
//                        PrintWriter out = response.getWriter();
//                        out.print("<font size='2'>上传文件为:"+name+"<br>保存的地址为"+path+ "</font>");
                        
                        response.setCharacterEncoding("UTF-8");
                        response.setContentType("application/json; charset=utf-8");
                        String jsonStr = "{\"filePath\":\""+path+"\",\"name\":\""+name+"\"}";
                        PrintWriter out = null;
                        try {
                            out = response.getWriter();
                            out.write(jsonStr);
                        } catch (IOException e) {
                            e.printStackTrace();
                        } finally {
                            if (out != null) {
                                out.close();
                            }
                        }
                    }
                }
            }catch(Exception e){
                e.printStackTrace();
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
//		System.out.println("123456231231233123");
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
