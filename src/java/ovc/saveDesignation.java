/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ovc;

import database.dbConn;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author MANUEL
 */
public class saveDesignation extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");
            
            
            String dis=request.getParameter("dis");
            String msg="<font color='green'> "+dis+" added succesfully !</font>";
            
            dbConn conn=new dbConn();
            IdGenerator ig=new IdGenerator();
            String id=ig.current_id().trim();
            String insertdes="Insert into designation (id,designation) value ('"+id+"','"+dis+"') ";
            //check first whether the designation exists
            
            String optionsadded=id+"%"+dis;
            String check="select * from designation where designation like '"+dis+"'";
            
            
            conn.rs=conn.st.executeQuery(check);
            
            if (conn.rs.next()){
               
                  msg="<font color='red'> "+dis+" Already exists </font>";
                //excecute the insert statement
                optionsadded=conn.rs.getString(1)+"%"+dis;
                
              
                
            }
            else {
            conn.st0.executeUpdate(insertdes);
            //get the id
            
            
                 }
            
               if(conn.rs!=null){conn.rs.close();}   
           
        
         if(conn.st0!=null){conn.st0.close();}  
         if(conn.st!=null){conn.st.close();}  
        
            
            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */
                
                out.println(msg+"@"+optionsadded);
            }
        }   catch (SQLException ex) {
            Logger.getLogger(saveDesignation.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
