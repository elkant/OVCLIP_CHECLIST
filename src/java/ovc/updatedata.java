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
import java.text.Format;
import java.text.SimpleDateFormat;
import java.util.Date;
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
public class updatedata extends HttpServlet {

   HttpSession session=null; 
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        session=request.getSession();
        
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
         String asses_type="";   
         String lip="";   
         String site="";   
         String staffpresent="";   
         String teamleader="";   
         String ass_date="";   
         String [] teammembers=null;  
         String no_of_elements="0";   
         //initialize objects of classes
         String totalsum="";
         
         String backgroundid="";
        // gen g=new gen();
         
         String msg="<font color='green'> data saved Succesfully </font>";
         
         dbConn conn= new dbConn();
         //===========================THE LINK OF TEH DATABASE FOR TEH THREE TABLES=========
         
         
        String markstableid="";
        //markstableid=g.uniqueid().trim();
        
        String userid="";
         
         if(session.getAttribute("userid")!=null){
         userid=session.getAttribute("userid").toString();
         
         }
         
         no_of_elements=request.getParameter("no_of_elements");
         
         asses_type=request.getParameter("asses_type");
         lip=request.getParameter("lip");
         site=request.getParameter("site");
         staffpresent=request.getParameter("staffpresent").toUpperCase();
         teamleader=request.getParameter("teamleader");
         teammembers=request.getParameterValues("teammembers");
         ass_date=request.getParameter("ass_date");
         totalsum=request.getParameter("totalsum");
         backgroundid=request.getParameter("backgroundid");
         String fulldates[]=ass_date.split("-");
         String constraint="";
         String strength="";
         strength=request.getParameter("strengths");
         constraint=request.getParameter("constraints");
         //fulldates[0]=Year
         //fulldates[1]=Month
         //fulldates[2]=date
         
         String year=fulldates[0];
         String month=fulldates[1];
         
  //define a quarter______       
         String quarters="";
System.out.println(ass_date);
if(fulldates[1].equals("10")||fulldates[1].equals("11")||fulldates[1].equals("12")){ quarters="1";}
else if(fulldates[1].equals("01")||fulldates[1].equals("02")||fulldates[1].equals("03")){ quarters="2";}
else if(fulldates[1].equals("04")||fulldates[1].equals("05")||fulldates[1].equals("06")){ quarters="3";}
else if(fulldates[1].equals("07")||fulldates[1].equals("08")||fulldates[1].equals("09")){ quarters="4";}
else{quarters="0";}
         
//        session.setAttribute("period",quarters);
//        session.setAttribute("year",year);       
//        session.setAttribute("ass_date",ass_date);       
//        session.setAttribute("markstableid",markstableid);
         
         String temabmembersstring="";
         if(request.getParameterValues("teammembers")!=null){
         for(int a=0;a<teammembers.length;a++){
         
         temabmembersstring+=teammembers[a]+",";
         if(a<teammembers.length-1){
              temabmembersstring+=teammembers[a]+",";
         }else {
          temabmembersstring+=teammembers[a];
          }
         }
         }
         
         
         
         
         //get the scores per domain and save them continuosly
         //get the value per mark, and save them continuosly
         //split the date to get month and year.
         
         //enter the background information
         
         //first check whether the data exists in the two main tables for a given quarter and site
         
        
         //do an insert instead of update
             msg="<font color='green'> data updated Succesfully </font>";
        
         
         if(1==1){
         
                  Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String mdate;

                    Date mydate = new Date();
                    mdate = formatter.format(mydate); 
             
         String bacgroundinfor="update backgroundinfor set cbo=?,site=?,staff_present=?,supervisor=?,ass_date=?,other_team_members=?,year=?,period=?,ass_type=?,totalsum=?,timestamp=?,strengths=?,constraints=? where backgroundid='"+backgroundid+"' ";
             
         conn.pst2=conn.conne.prepareStatement(bacgroundinfor);
          
          conn.pst2.setString(1,lip); 
          conn.pst2.setString(2,site); 
          conn.pst2.setString(3,staffpresent); 
          conn.pst2.setString(4,teamleader); 
          conn.pst2.setString(5,ass_date); 
          conn.pst2.setString(6,temabmembersstring);         
          conn.pst2.setString(7,year); 
          conn.pst2.setString(8,quarters); 
          conn.pst2.setString(9,asses_type); 
          conn.pst2.setString(10,totalsum); 
          conn.pst2.setString(11,mdate); 
          conn.pst2.setString(12,strength); 
          conn.pst2.setString(13,constraint); 
          conn.pst2.executeUpdate(); 
         
         }
         
         
         int maxdomain=0;
         
         String maxd="select MAX(domain_id) from domains ";
         
         conn.rs=conn.st.executeQuery(maxd);
         
         while(conn.rs.next()){
         
         maxdomain=conn.rs.getInt(1);
         }
         
         //now save the values per domain
         for(int c=1;c<=maxdomain;c++){
         
             if(request.getParameter("domaininput"+c)!=null){
             
                 String domainvalue=request.getParameter("domaininput"+c);
                 String domaintableid=request.getParameter("domaintableid"+c);
                 String domainid=""+c;
                        Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String mdate;

                    Date mydate = new Date();
                    mdate = formatter.format(mydate); 
                 
                 String insert="update domain_totals set value=?,aggregate_sum=?,period=?,month=?,userid=?,date=?,site=?,year=?,timestamp=? where tableid='"+domaintableid+"' ";
                       
             conn.pst2=conn.conne.prepareStatement(insert);
    
              
             conn.pst2.setString(1,domainvalue); 
             conn.pst2.setString(2,totalsum); 
             conn.pst2.setString(3,quarters); 
             conn.pst2.setString(4,month);            
             conn.pst2.setString(5,userid); 
             conn.pst2.setString(6,ass_date); 
             conn.pst2.setString(7,site); 
             conn.pst2.setString(8,year); 
             conn.pst2.setString(9,mdate); 
             conn.pst2.executeUpdate();    
             
             }
             
         
         
         }
         
         
         
         
         int totalelements=Integer.parseInt(no_of_elements);
         
        for(int b=1;b<=totalelements;b++) 
        {
        
       
        
        if(request.getParameter("element_"+b)!=null)
        {
            
         Format formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                    String mdate;

                    Date mydate = new Date();
                    mdate = formatter.format(mydate);    
            
            
         String val=request.getParameter("element_"+b);
         String comment=request.getParameter("comment"+b);
         String marktableid=request.getParameter("qidelement_"+b);
         String element="element_"+b;
         String questionid=""+b;
        String insert="update marks set answer=?,period=?,userid=?,date=?,year=?,month=?,timestamp=?,site_id=? ,comment=? where marks_id='"+marktableid+"'";
 
         conn.pst2=conn.conne.prepareStatement(insert);
        
             
             conn.pst2.setString(1,val);
             conn.pst2.setString(2,quarters);
             conn.pst2.setString(3,userid);
             conn.pst2.setString(4,ass_date);
             conn.pst2.setString(5,year);
             conn.pst2.setString(6,month);
             conn.pst2.setString(7,mdate);
             conn.pst2.setString(8,site);
             conn.pst2.setString(9,comment);          
         
             conn.pst2.executeUpdate();
            System.out.println("^^^^^^^^^^^^^^^^^"+comment);
        }
        else
        {
            System.out.println("Skipped element number"+ b);
        }
        
        }
         
              if (conn.rs != null) {
                conn.rs.close();
            }
              if (conn.st!= null) {
                conn.st.close();
            }
            if (conn.pst1 != null) {
                conn.pst1.close();
            }
            if (conn.pst2 != null) {
                conn.pst2.close();
            }

            if (conn.conne != null) {
                conn.conne.close();
            }
           
        
            out.println(msg);
        } catch (SQLException ex) {
           Logger.getLogger(savedata.class.getName()).log(Level.SEVERE, null, ex);
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
