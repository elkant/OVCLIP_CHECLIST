/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import database.dbConn;
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

/**
 *
 * @author Emmanuel E
 */
public class syncdata extends HttpServlet {

   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        
        
         response.setContentType("text/html;charset=UTF-8");
            try (PrintWriter out = response.getWriter()) {
                
                out.println("</html>");
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



public boolean doSyncing(){


System.out.println("Now syncing_________________________");
        
        try {
            
            
            
            
            dbConn loccon=new dbConn();
            dbConnweb webcon=new dbConnweb();
            
            
            //MERGE ACTION POINT 
            
              String getactionpoint="select * from action_points where issynced='0'";
            
            loccon.rs=loccon.st.executeQuery(getactionpoint);
            
            while(loccon.rs.next()){
            //now check existance in the cloud using the unique id
                    
        String checkactionpoint="select ass_date,timestamp from action_points where tableid = '"+loccon.rs.getString(1)+"'";        
         
        webcon.rs=webcon.st.executeQuery(checkactionpoint);
        if(webcon.rs.next()){
        //if exists, then check timestamp
            //if equal, update
        if(loccon.rs.getTimestamp("timestamp").equals(webcon.rs.getTimestamp("timestamp"))){
        
        
        String update="update backgroundinfor set cbo='"+loccon.rs.getString("cbo")+"', site='"+loccon.rs.getString("site")+"' , staff_present='"+loccon.rs.getString("staff_present")+"' ,supervisor='"+loccon.rs.getString("supervisor")+"', ass_date='"+loccon.rs.getString("ass_date")+"', other_team_members='"+loccon.rs.getString("other_team_members")+"',timestamp='"+loccon.rs.getString("timestamp")+"', year='"+loccon.rs.getString("year")+"', period='"+loccon.rs.getString("period")+"' , ass_type='"+loccon.rs.getString("ass_type")+"', totalsum='"+loccon.rs.getString("totalsum")+"' , strengths='"+loccon.rs.getString("strengths")+"',constraints='"+loccon.rs.getString("constraints")+"', issynced='1' where backgroundid='"+loccon.rs.getString(1)+"' ";
        
        webcon.st1.executeUpdate(update);
        
        }
        
        
        }
        //if not exists, do an insert
         else{
        
         // String insert="insert into backgroundinfor set cbo=?, site='"+loccon.rs.getString("site")+"' , staff_present='"+loccon.rs.getString("staff_present")+"' ,supervisor='"+loccon.rs.getString("supervisor")+"', ass_date='"+loccon.rs.getString("ass_date")+"', other_team_members='"+loccon.rs.getString("other_team_members")+"',timestamp='"+loccon.rs.getString("timestamp")+"', year='"+loccon.rs.getString("year")+"', period='"+loccon.rs.getString("period")+"' , ass_type='"+loccon.rs.getString("ass_type")+"', totalsum='"+loccon.rs.getString("totalsum")+"' , strengths='"+loccon.rs.getString("strengths")+"',constraints='"+loccon.rs.getString("constraints")+"', issynced='1' , backgroundid='"+loccon.rs.getString(1)+"' ";
          //String insert="insert into backgroundinfor  constraints='"+loccon.rs.getString("constraints")+"', issynced='1' , backgroundid='"+loccon.rs.getString(1)+"' ";
          
             String bacgroundinfor="insert into backgroundinfor (backgroundid,cbo,site,staff_present,supervisor,ass_date,other_team_members,marks_table_id,year,period,ass_type,totalsum,strengths,constraints) values "
                 + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
          webcon.pst2=webcon.conne.prepareStatement(bacgroundinfor);
          webcon.pst2.setString(1,loccon.rs.getString(1)); 
          webcon.pst2.setString(2,loccon.rs.getString("cbo")); 
          webcon.pst2.setString(3,loccon.rs.getString("site")); 
          webcon.pst2.setString(4,loccon.rs.getString("staff_present")); 
          webcon.pst2.setString(5,loccon.rs.getString("supervisor")); 
          webcon.pst2.setString(6,loccon.rs.getString("ass_date")); 
          webcon.pst2.setString(7,loccon.rs.getString("other_team_members")); 
          webcon.pst2.setString(8,loccon.rs.getString("timestamp")); 
          webcon.pst2.setString(9,loccon.rs.getString("year")); 
          webcon.pst2.setString(10,loccon.rs.getString("period")); 
          webcon.pst2.setString(11,loccon.rs.getString("ass_type")); 
          webcon.pst2.setString(12,loccon.rs.getString("totalsum")); 
          webcon.pst2.setString(13,loccon.rs.getString("strengths")); 
          webcon.pst2.setString(14,loccon.rs.getString("constraints")); 
          webcon.pst2.executeUpdate(); 
          
      }
            
            
           loccon.st2.executeUpdate("update backgroundinfor set issynced='1' where backgroundid='"+loccon.rs.getString(1)+"' ");
             
            
            }//end of bcakground infor
            
          
            
            
            
            
            //MERGE BACKGROUND INFOR
            
            String getbacinfor="select * from backgroundinfor where issynced='0'";
            
            loccon.rs=loccon.st.executeQuery(getbacinfor);
            
            while(loccon.rs.next()){
            //now check existance in the cloud using the unique id
                    
        String checkbainfor="select ass_date,timestamp from backgroundinfor where backgroundid = '"+loccon.rs.getString(1)+"'";        
         
        webcon.rs=webcon.st.executeQuery(checkbainfor);
        if(webcon.rs.next()){
        //if exists, then check timestamp
            //if equal, update
        if(loccon.rs.getTimestamp("timestamp").equals(webcon.rs.getTimestamp("timestamp"))){
        
        
        String update="update backgroundinfor set cbo='"+loccon.rs.getString("cbo")+"', site='"+loccon.rs.getString("site")+"' , staff_present='"+loccon.rs.getString("staff_present")+"' ,supervisor='"+loccon.rs.getString("supervisor")+"', ass_date='"+loccon.rs.getString("ass_date")+"', other_team_members='"+loccon.rs.getString("other_team_members")+"',timestamp='"+loccon.rs.getString("timestamp")+"', year='"+loccon.rs.getString("year")+"', period='"+loccon.rs.getString("period")+"' , ass_type='"+loccon.rs.getString("ass_type")+"', totalsum='"+loccon.rs.getString("totalsum")+"' , strengths='"+loccon.rs.getString("strengths")+"',constraints='"+loccon.rs.getString("constraints")+"', issynced='1' where backgroundid='"+loccon.rs.getString(1)+"' ";
        
        webcon.st1.executeUpdate(update);
        
        }
        
        
        }
        //if not exists, do an insert
         else{
        
         // String insert="insert into backgroundinfor set cbo=?, site='"+loccon.rs.getString("site")+"' , staff_present='"+loccon.rs.getString("staff_present")+"' ,supervisor='"+loccon.rs.getString("supervisor")+"', ass_date='"+loccon.rs.getString("ass_date")+"', other_team_members='"+loccon.rs.getString("other_team_members")+"',timestamp='"+loccon.rs.getString("timestamp")+"', year='"+loccon.rs.getString("year")+"', period='"+loccon.rs.getString("period")+"' , ass_type='"+loccon.rs.getString("ass_type")+"', totalsum='"+loccon.rs.getString("totalsum")+"' , strengths='"+loccon.rs.getString("strengths")+"',constraints='"+loccon.rs.getString("constraints")+"', issynced='1' , backgroundid='"+loccon.rs.getString(1)+"' ";
          //String insert="insert into backgroundinfor  constraints='"+loccon.rs.getString("constraints")+"', issynced='1' , backgroundid='"+loccon.rs.getString(1)+"' ";
          
             String bacgroundinfor="insert into backgroundinfor (backgroundid,cbo,site,staff_present,supervisor,ass_date,other_team_members,marks_table_id,year,period,ass_type,totalsum,strengths,constraints) values "
                 + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
          webcon.pst2=webcon.conne.prepareStatement(bacgroundinfor);
          webcon.pst2.setString(1,loccon.rs.getString(1)); 
          webcon.pst2.setString(2,loccon.rs.getString("cbo")); 
          webcon.pst2.setString(3,loccon.rs.getString("site")); 
          webcon.pst2.setString(4,loccon.rs.getString("staff_present")); 
          webcon.pst2.setString(5,loccon.rs.getString("supervisor")); 
          webcon.pst2.setString(6,loccon.rs.getString("ass_date")); 
          webcon.pst2.setString(7,loccon.rs.getString("other_team_members")); 
          webcon.pst2.setString(8,loccon.rs.getString("timestamp")); 
          webcon.pst2.setString(9,loccon.rs.getString("year")); 
          webcon.pst2.setString(10,loccon.rs.getString("period")); 
          webcon.pst2.setString(11,loccon.rs.getString("ass_type")); 
          webcon.pst2.setString(12,loccon.rs.getString("totalsum")); 
          webcon.pst2.setString(13,loccon.rs.getString("strengths")); 
          webcon.pst2.setString(14,loccon.rs.getString("constraints")); 
          webcon.pst2.executeUpdate(); 
          
      }
            
            
           loccon.st2.executeUpdate("update backgroundinfor set issynced='1' where backgroundid='"+loccon.rs.getString(1)+"' ");
             
            
            }//end of bcakground infor
            
            //MARKS
            
            
            
            
            String getmarks="select * from marks where issynced='0'";
            loccon.rs=loccon.st.executeQuery(getmarks);
            
            while(loccon.rs.next()){
            //check existance
                
                String checkexist="select marks_id, timestamp from marks where marks_id='"+loccon.rs.getString(1)+"' ";
            //if exists, compare time
             webcon.rs=webcon.st.executeQuery(checkexist);
             if(webcon.rs.next()){
             
             if(loccon.rs.getTimestamp("timestamp").equals(webcon.rs.getTimestamp("timestamp"))){
        
        
        String update="update marks set quest_id='"+loccon.rs.getString("quest_id")+"', answer='"+loccon.rs.getString("answer")+"' , period='"+loccon.rs.getString("period")+"' ,timestamp='"+loccon.rs.getString("timestamp")+"', date='"+loccon.rs.getString("date")+"', year='"+loccon.rs.getString("year")+"',month='"+loccon.rs.getString("month")+"', site_id='"+loccon.rs.getString("site_id")+"', marks_table_id='"+loccon.rs.getString("marks_table_id")+"' , comment='"+loccon.rs.getString("comment")+"', issynced='1' where marks_id='"+loccon.rs.getString(1)+"' ";
        
        webcon.st1.executeUpdate(update);
        
        }
             
            }
             else {
             //do an insert  now
                 
              String insert="insert into marks (marks_id,quest_id,answer,period,userid,timestamp,date,year,month,syncdate,site_id,marks_table_id,comment,issynced) value "
                + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?)"; 
         webcon.pst2=webcon.conne.prepareStatement(insert);
             webcon.pst2.setString(1,loccon.rs.getString(1));
             webcon.pst2.setString(2,loccon.rs.getString(2));
             webcon.pst2.setString(3,loccon.rs.getString(3));
             webcon.pst2.setString(4,loccon.rs.getString(4));
             webcon.pst2.setString(5,loccon.rs.getString(5));
             webcon.pst2.setString(6,loccon.rs.getString(6));
             webcon.pst2.setString(7,loccon.rs.getString(7));
             webcon.pst2.setString(8,loccon.rs.getString(8));
             webcon.pst2.setString(9,loccon.rs.getString(9));
             webcon.pst2.setString(10,loccon.rs.getString(10));
             webcon.pst2.setString(11,loccon.rs.getString(11));
             webcon.pst2.setString(12,loccon.rs.getString(12));         
             webcon.pst2.setString(13,loccon.rs.getString(13));         
             webcon.pst2.setString(14,loccon.rs.getString(14));         
             webcon.pst2.executeUpdate();   
             
             
            // if update done, update issynced to 
             
             
            }
              loccon.st2.executeUpdate("update marks set issynced='1' where marks_id='"+loccon.rs.getString(1)+"' ");
            
            
            }
            
            //DOMAIN TOTALS
            
            
              
            String getdomaintotals="select * from domain_totals where issynced='0'";
            loccon.rs=loccon.st.executeQuery(getdomaintotals);
            
            while(loccon.rs.next()){
            //check existance
                
                String checkexist="select tableid, timestamp from domain_totals where tableid='"+loccon.rs.getString(1)+"' ";
            //if exists, compare time
             webcon.rs=webcon.st.executeQuery(checkexist);
             if(webcon.rs.next()){
             
             if(loccon.rs.getTimestamp("timestamp").equals(webcon.rs.getTimestamp("timestamp"))){
        
        
        String update="update domain_totals set domainid='"+loccon.rs.getString("domainid")+"', value='"+loccon.rs.getString("value")+"' , aggregate_sum='"+loccon.rs.getString("aggregate_sum")+"' ,period='"+loccon.rs.getString("period")+"', month='"+loccon.rs.getString("month")+"', syncdate='"+loccon.rs.getString("syncdate")+"', timestamp='"+loccon.rs.getString("timestamp")+"', date='"+loccon.rs.getString("date")+"' , year='"+loccon.rs.getString("year")+"' , marks_table_id='"+loccon.rs.getString("marks_table_id")+"' , site='"+loccon.rs.getString("site")+"', issynced='1' where tableid='"+loccon.rs.getString(1)+"' ";
        
        webcon.st1.executeUpdate(update);
        
        }
             
            }
             else {
             //do an insert  now
                 
             String insert="insert into domain_totals (tableid,domainid,value,aggregate_sum,period,month,syncdate,timestamp,userid,date,year,marks_table_id,site,issynced) values "
                         + "(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
             webcon.pst2=webcon.conne.prepareStatement(insert);
             webcon.pst2.setString(1,loccon.rs.getString(1));
             webcon.pst2.setString(2,loccon.rs.getString(2)); 
             webcon.pst2.setString(3,loccon.rs.getString(3)); 
             webcon.pst2.setString(4,loccon.rs.getString(4)); 
             webcon.pst2.setString(5,loccon.rs.getString(5)); 
             webcon.pst2.setString(6,loccon.rs.getString(6)); 
             webcon.pst2.setString(7,loccon.rs.getString(7)); 
             webcon.pst2.setString(8,loccon.rs.getString(8)); 
             webcon.pst2.setString(9,loccon.rs.getString(9)); 
             webcon.pst2.setString(10,loccon.rs.getString(10)); 
             webcon.pst2.setString(11,loccon.rs.getString(11)); 
             webcon.pst2.setString(12,loccon.rs.getString(12)); 
             webcon.pst2.setString(13,loccon.rs.getString(13)); 
             webcon.pst2.setString(14,loccon.rs.getString(14)); 
             webcon.pst2.executeUpdate();    
              
             
             
            // if update done, update issynced to 
             
             
           }
              loccon.st2.executeUpdate("update domain_totals set issynced='1' where tableid='"+loccon.rs.getString(1)+"' ");
             
            
            }//end of domain_totals
            
            
            //STAFF
            
            
             String getstaff="select * from staff where issynced='0'";
            loccon.rs=loccon.st.executeQuery(getstaff);
            
            while(loccon.rs.next()){
            //check existance
                
                String checkexist="select staff_id, timestamp from staff where staff_id='"+loccon.rs.getString(1)+"' ";
            //if exists, compare time
             webcon.rs=webcon.st.executeQuery(checkexist);
             if(webcon.rs.next()){
             
             if(loccon.rs.getTimestamp("timestamp").equals(webcon.rs.getTimestamp("timestamp"))){
        
        
        String update="update staff set fname='"+loccon.rs.getString("fname")+"', mname='"+loccon.rs.getString("mname")+"' , phone='"+loccon.rs.getString("phone")+"' ,role_id='"+loccon.rs.getString("role_id")+"', userid='"+loccon.rs.getString("userid")+"', site_id='"+loccon.rs.getString("site_id")+"', timestamp='"+loccon.rs.getString("timestamp")+"',  issynced='1' where staff_id='"+loccon.rs.getString(1)+"' ";
        
        webcon.st1.executeUpdate(update);
        
        }
             
            }
             else {
             //do an insert  now
            
            String insert="insert into staff (staff_id,fname,mname,phone,role_id,userid,site_id) values (?,?,?,?,?,?,?)";
            
            webcon.pst1=webcon.conne.prepareStatement(insert);
           
            webcon.pst1.setString(1,loccon.rs.getString(1));
            webcon.pst1.setString(2,loccon.rs.getString(2));
            webcon.pst1.setString(3,loccon.rs.getString(3));
            webcon.pst1.setString(4,loccon.rs.getString(4));
            webcon.pst1.setString(5,loccon.rs.getString(5));
            webcon.pst1.setString(6,loccon.rs.getString(6));
            webcon.pst1.setString(7,loccon.rs.getString(7));        
        
            
            webcon.pst1.executeUpdate();
              
             
             
            // if update done, update issynced to 
             
             
           }
            
             loccon.st2.executeUpdate("update staff set issynced='1' where staff_id='"+loccon.rs.getString(1)+"' ");
             
            }//end of staff
            
          
            
            
             String getuser="select * from users where issynced='0'";
            loccon.rs=loccon.st.executeQuery(getuser);
            
            while(loccon.rs.next()){
            //check existance
               
                String checkexist="select userid, timestamp from users where userid='"+loccon.rs.getString(1)+"' ";
                   System.out.println(checkexist); 
            //if exists, compare time
             webcon.rs=webcon.st.executeQuery(checkexist);
             if(webcon.rs.next()){
             
             if(loccon.rs.getTimestamp("timestamp").equals(webcon.rs.getTimestamp("timestamp"))){
        
        
        String update="update users set username='"+loccon.rs.getString("username")+"',  fname='"+loccon.rs.getString("fname")+"', mname='"+loccon.rs.getString("mname")+"' , password='"+loccon.rs.getString("password")+"' , phonenumber='"+loccon.rs.getString("phonenumber")+"', timestamp='"+loccon.rs.getString("timestamp")+"',  issynced='1' where userid='"+loccon.rs.getString(1)+"' ";
        
        webcon.st1.executeUpdate(update);
        
        }
             
            }
             else {
             //do an insert  now
            
            String insert="insert into users (userid,username,fname,mname,password,userlevel,phonenumber,issynced,timestamp) values (?,?,?,?,?,?,?,?,?)";
            
            webcon.pst1=webcon.conne.prepareStatement(insert);
           
            webcon.pst1.setString(1,loccon.rs.getString(1));
            webcon.pst1.setString(2,loccon.rs.getString(2));
            webcon.pst1.setString(3,loccon.rs.getString(3));
            webcon.pst1.setString(4,loccon.rs.getString(4));
            webcon.pst1.setString(5,loccon.rs.getString(5));
            webcon.pst1.setString(6,loccon.rs.getString(6));
            webcon.pst1.setString(7,loccon.rs.getString(7));        
            webcon.pst1.setString(8,loccon.rs.getString(8));        
            webcon.pst1.setString(9,loccon.rs.getString(9));        
        
            
            webcon.pst1.executeUpdate();
                          
             
            // if update done, update issynced to 
             
             
           }
            
             loccon.st2.executeUpdate("update users set issynced='1' where userid='"+loccon.rs.getString(1)+"' ");
              
            }//end of users
            
            
            
          //close connections
            
            if(loccon.st!=null){loccon.st.close();}
            
            if(loccon.st2!=null){loccon.st2.close();}
            if(loccon.rs!=null){loccon.rs.close();}
            if(loccon.conne!=null){loccon.conne.close();}
           
            if(webcon.st!=null){webcon.st.close();}
            if(webcon.st1!=null){webcon.st1.close();}
            if(webcon.rs!=null){webcon.rs.close();}
            if(webcon.pst1!=null){webcon.pst1.close();}
            if(webcon.conne!=null){webcon.conne.close();}
           
            
            
           
        }   catch (SQLException ex) {
            Logger.getLogger(syncdata.class.getName()).log(Level.SEVERE, null, ex);
        }
    

return true;
}

}
