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
import javax.servlet.http.HttpSession;

/**
 *
 * @author MANUEL
 */
public class updateactionpoint extends HttpServlet {

  HttpSession session=null;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        session=request.getSession();
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
          
           String tableid="";
           String action="";
           String responsibleperson="";
           String expecteddate="";
           String expecteddate2="";
           String joiningnumber="";
           String counter=request.getParameter("counter");
           
           //
           
           
            String period="";
            String year="";
            String ass_date="";
            String markstableid="";
            String siteid="";
            String cbo="";
            
            
           if(request.getParameter("ass_date")!=null&&!request.getParameter("ass_date").equals("")){
           ass_date=request.getParameter("ass_date");
           
           String fulldates[]=ass_date.split("-");
           year=fulldates[0];
         if(fulldates[1].equals("10")||fulldates[1].equals("11")||fulldates[1].equals("12")){ period="1";}
else if(fulldates[1].equals("01")||fulldates[1].equals("02")||fulldates[1].equals("03")){ period="2";}
else if(fulldates[1].equals("04")||fulldates[1].equals("05")||fulldates[1].equals("06")){ period="3";}
else if(fulldates[1].equals("07")||fulldates[1].equals("08")||fulldates[1].equals("09")){ period="4";}
else{period="0";}
           
           
           
           
           } 
           if(request.getParameter("site")!=null){
           siteid=request.getParameter("site");
           
           }
           
           if(request.getParameter("lip")!=null){
           cbo=request.getParameter("lip");
           
           }
           
            dbConn conn= new dbConn();
            
            gen g= new gen();
           
         String msg="<font color=\"orange\">Data updated Succesfully</font>";  
           
           int cnt=Integer.parseInt(counter);
            for(int a=1;a<=cnt;a++){
           if(!request.getParameter("actionid"+a).trim().equals("")){
            responsibleperson=request.getParameter("select"+a);   
            expecteddate=request.getParameter("fdate"+a);   
            expecteddate2=request.getParameter("sdate"+a);   
            action=request.getParameter("actionid"+a);  
           
            String uniqid=g.uniqueid().trim();
            
           
            if(request.getParameter("tableid"+a)!=null){
            //do an update
             tableid=request.getParameter("tableid"+a);
                
             String insertdata="update action_points set followupid=?,responsible_person=?,expected_date=?,expected_date2=? where tableid='"+tableid+"'";
            
            
             conn.pst2=conn.conne.prepareStatement(insertdata);
        
             conn.pst2.setString(1,action);
             conn.pst2.setString(2,responsibleperson);
             conn.pst2.setString(3,expecteddate);
             conn.pst2.setString(4,expecteddate2);
            
            conn.pst2.executeUpdate();
                
                
            }
            else { 
            String insertdata="insert into action_points (tableid,followupid,responsible_person,expected_date,expected_date2,site_id,marks_table_id,period,year,ass_date) values(?,?,?,?,?,?,?,?,?,?)";
            
            
             conn.pst2=conn.conne.prepareStatement(insertdata);
             conn.pst2.setString(1,uniqid);
             conn.pst2.setString(2,action);
             conn.pst2.setString(3,responsibleperson);
             conn.pst2.setString(4,expecteddate);
             conn.pst2.setString(5,expecteddate2);
             conn.pst2.setString(6,siteid);
             conn.pst2.setString(7,markstableid);
             conn.pst2.setString(8,period);
             conn.pst2.setString(9,year);
             conn.pst2.setString(10,ass_date);
            conn.pst2.executeUpdate();
             
            
                                  }
             
            }
            }//end of checker of if data has already been inserted
           
            
            if (conn.rs != null) {
                conn.rs.close();
            }
            if (conn.rs2 != null) {
                conn.rs2.close();
            }

            if (conn.pst2 != null) {
                conn.pst2.close();
            }
            if (conn.conne != null) {
                conn.conne.close();
            }
            if (conn.st2 != null) {
                conn.st2.close();
            }
         
            
           session.setAttribute("actionmsg",msg); 
           out.println(msg);
            System.out.println("____________"+msg);
           //response.sendRedirect("dataentry.htm");
        } catch (SQLException ex) {
            Logger.getLogger(updateactionpoint.class.getName()).log(Level.SEVERE, null, ex);
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
