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
 * @author Emmanuel E
 */
public class assesmentType extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
        String siteid="";
      
        String asses="<option value=''>Select Assesment</option>";
        String year="";
        String quarter="";
         dbConn conn = new dbConn();
        
      year=request.getParameter("year");
      quarter=request.getParameter("quarter");
      siteid=request.getParameter("siteid");
         
         //check if the site has had an initial assesment
//ask joel if a site can have initial assements more than once that we should av
       //  and year='"+year+"' and period='"+quarter+"'
         
         String checkinitassesment="select * from backgroundinfor where ass_type='1' and site='"+siteid+"' ";
         
         conn.rs=conn.st.executeQuery(checkinitassesment);
         
         if(conn.rs.next()){
            String getass = "select * from asses_type where asses_id!='1'";
            conn.rs0 = conn.st0.executeQuery(getass);
            while (conn.rs0.next()) {
                asses += "<option value='" + conn.rs0.getString(1) + "'>" + conn.rs0.getString(2) + "</option>";

            }
            }
         else {
         
          asses += "<option value='1'>Initial Assesment</option>";

         }
            
            
            out.println(asses);
            
            if(conn.rs0!=null){conn.rs0.close();}
            if(conn.st0!=null){conn.st0.close();}
            if(conn.st!=null){conn.st.close();}
            if(conn.rs!=null){conn.rs.close();}
            
        } catch (SQLException ex) {
            Logger.getLogger(assesmentType.class.getName()).log(Level.SEVERE, null, ex);
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
