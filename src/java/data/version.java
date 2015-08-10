/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package data;


import database.dbConnweb;
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
 * @author Geofrey Nyabuto
 */
public class version extends HttpServlet {
HttpSession session;
String status,versionid,version_name,versionDate,url;
int days,maxId,system_version,maxDays,daysRemaining,daysOutdated;
boolean isConnected;
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {
          system_version=1;maxDays=10;daysRemaining=0;daysOutdated=0;
          days=maxId=0;versionDate="";
       url="";
         isConnected=true;
         
         if(isConnected==true){
          dbConnweb conn = new dbConnweb();
//           dbConnect conn = new dbConnect();
           
         String getLatestVersion="SELECT MAX(version_id) FROM version";
         conn.rs=conn.st.executeQuery(getLatestVersion);
         if(conn.rs.next()==true){
          maxId=conn.rs.getInt(1);
         }
         System.out.println("max id :"+maxId);
          if(maxId>system_version) {
           String getDays="SELECT DATEDIFF(NOW(),date_updated),date_updated,version_name,url FROM version WHERE version_id='"+maxId+"'";
           conn.rs1=conn.st.executeQuery(getDays);
           if(conn.rs1.next()==true){
               days=conn.rs1.getInt(1);
               versionDate=conn.rs1.getString(2);
               version_name=conn.rs1.getString(3);
               url=conn.rs1.getString(4);
               System.out.println("days : "+days);
           }
           if(days>10){
               daysOutdated=days-maxDays;
               status="outdated@@"+days+"@@"+versionDate+"@@"+version_name;
               status="<p style='color:red'>You are using an outdated version of DIC system,Please <a href='"+url+"' target='_blank'>Click here to download updates.</a><img src='images/new_arrow2.gif' style='width: 40px; height:40px;'/></p>" +
               "<p title=\"Latest Version is "+version_name+" and its updates were sent on "+versionDate+"\">This version became outdated <b>"+daysOutdated+"</b> days ago.</b>";

           }
           else{
               daysRemaining=maxDays-days;
               status="warning@@"+daysRemaining+"@@"+versionDate+"@@"+version_name;
               
               status="<p style='color:yellow'>A new version of OVC Checklist system is available ,Please <a href='"+url+"' target='_blank'>Click here to download updates.</a><img src='images/new_arrow2.gif' style='width: 40px; height:40px;'/></p>" +
             "<p title=\"Latest Version is "+version_name+" and its updates were sent on "+versionDate+"\">Your have <b>"+daysRemaining+"</b> days remaining to update your system.</p>";
           }
          }
          else{
              status="current";
              status="<p style='color: green'>Your OVC Checklist System is updated.</p>";
          }
          
     if(conn.st!=null){conn.st.close();}
     if(conn.st1!=null){conn.st1.close();}
//     if(conn.st2!=null){conn.st2.close();}
     
     if(conn.rs!=null){conn.rs.close();}
     if(conn.rs1!=null){conn.rs1.close();}
//     if(conn.rs2!=null){conn.rs2.close();}
     if(conn.conne!=null){conn.conne.close();} 
     
         }
         else{
             status="no_internet";
         }
         
     
         
            out.println(status);
        } finally {
            out.close();
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
    try {
        processRequest(request, response);
    } catch (SQLException ex) {
        Logger.getLogger(version.class.getName()).log(Level.SEVERE, null, ex);
    }
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
    try {
        processRequest(request, response);
    } catch (SQLException ex) {
        Logger.getLogger(version.class.getName()).log(Level.SEVERE, null, ex);
    }
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
