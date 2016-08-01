/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ovc;

import database.dbConn;
import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.sql.SQLException;
import java.util.ArrayList;
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
public class loadactionpoint extends HttpServlet {

    
    ArrayList designationsAL = null;
            ArrayList designationsALid = null;
     private static String allelements="";
           private static String allelementsvalues="";
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            response.setContentType("text/html;charset=UTF-8");

             allelements="";
             allelementsvalues="";
            
            String fyear="";
            String fsite="";
            String fcbo="";
            String fperiod="";
           String datevalue="";
          
           //this will hold a string of element names and values for preloading purpose
          
            
            
           
            fyear=request.getParameter("year");
            fsite=request.getParameter("site");
            fperiod=request.getParameter("period");
            fcbo=request.getParameter("cbo");
            
            
            String formedform = "";
       
            String lip = "<option value=''>Select LIP/CBO</option>";
            
            
            dbConn conn = new dbConn();
//add designations to an arraylist for creation of options while craeting a form
             designationsAL = new ArrayList();
             designationsALid = new ArrayList();

            String getdesignations = "select * from designation ";
            conn.rs0 = conn.st0.executeQuery(getdesignations);
            while (conn.rs0.next()) {
                designationsAL.add(conn.rs0.getString("designation"));
                designationsALid.add(conn.rs0.getString("id"));
                
            }
            
            
            
            
            
           //====================cbo

            String getlip = "select * from cbo";
            conn.rs0 = conn.st0.executeQuery(getlip);
            while (conn.rs0.next()) {
                
                if(conn.rs0.getString(1).equals(fcbo)){
                lip += "<option selected value='" + conn.rs0.getString(1) + "'>" + conn.rs0.getString(2) + "</option>";
                }
                else 
                    
                {
                 lip += "<option value='" + conn.rs0.getString(1) + "'>" + conn.rs0.getString(2) + "</option>";
                
                
                }
                                   }

            //===================SITES================
            String sites="<option value=''>select site</option>";
           
            String getsites="  select * from sites where cbo_id='"+fcbo+"'";
            conn.rs=conn.st.executeQuery(getsites);
            while(conn.rs.next()){
            
                if(conn.rs.getString(1).equals(fsite)){
                
                sites+="<option selected value='"+conn.rs.getString(1)+"'>"+conn.rs.getString(2)+"</option>";
            
                }
                else {
                
            sites+="<option value='"+conn.rs.getString(1)+"'>"+conn.rs.getString(2)+"</option>";
            
                   }
                                  }
            
            
            
         

        
              
              
           
            boolean createnewpage = true;
            String initdomain = "0";
            String getdata = "select * from action_points where site_id='"+fsite+"' and year='"+fyear+"' and period='"+fperiod+"'";
            conn.rs = conn.st.executeQuery(getdata);
            int counter = 0;
           
            String addeddata="";
            while(conn.rs.next()){            
            datevalue=conn.rs.getString("ass_date");
                   //create the entire table in this page..
             counter++;  
             addeddata+="<tr><td><input type='hidden' value='"+conn.rs.getString("tableid")+"' name='tableid"+counter+"'/><h3>"+counter+"</h3></td><td style='color:black;'><div class='form-group'>" +               
             "<Textarea rows='2' cols='30' class='form-control' name='actionid"+counter+"' id='actionid"+counter+"' >" +
             conn.rs.getString("followupid")+"</TextArea>" +
             "</div></td><td><div class=\"form-group\"><select name='select"+counter+"' class=\"form-control \" id='select"+counter+"'>"+createoptions(conn.rs.getString("responsible_person"))+"</select></div></td><td><div class=\"form-group\"><input class=\"form-control dates\" value="+conn.rs.getString("expected_date")+"  type='text' id='fdate"+counter+"' name='fdate"+counter+"'></div></td><td> <div class=\"form-group\"><input type='text' id='sdate"+counter+"' value='"+conn.rs.getString("expected_date")+"' class=\"form-control dates\" name='sdate"+counter+"'></div></td></tr>";   
            
            
            
            }
               formedform="<fieldset>"
                    + "<legend> Section A: Background Information </legend>"
                    + "<div class='row'>"
                    + "<div class='col-lg-6'>"
                    + ""
                   
                   + ""
                    + "<div class='form-group'>"
                    + "<label for='exampleInputPassword6'>Date of Assesment</label>"
                    + "<input type='text' value='"+datevalue+"' onchange='checkupdate();' class='form-control' name='ass_date' id='ass_date' >"
                    + "</div>"
                    + ""
                   
                    + ""
                    + "<div class=\"form-group\">\n"
                    + "<label for=\"exampleInputPassword6\">Name of LIP/CBO</label>\n"
                    + "<select class=\"form-control\" onchange='loadsites1();' name=\"lip\" id='lip' data-parsley-group=\"block0\" required>\n"
                    + "" + lip
                    + "</select>\n"
                    + "</div>"
                    + ""
                    + ""
                    + "<div class=\"form-group\">"
                    + "<label for=\"exampleInputPassword6\">Site Visited</label>\n"
                    + "<select class=\"form-control\" name=\"site\" id='site' onchange='checkupdate();determinefunction(this);' data-parsley-group=\"block0\" >\n"
                    + ""+sites
                    + "</select>"
                    + "</div>"
                    + ""
                    + ""
                   
                    + ""
                    + "</div>"
                    + ""
                    + "</div>"
                    + "</div>"
                    + "</fieldset>";

              formedform+="<fieldset><legend style='text-align:center;'>DQA ACTION POINT</legend>"
                    + "<div class='row' ><table ><tr><td><span><input type=\"text\" value=\"Add 1 Row\" id=\"generate1\" class ='generate1' onclick=\"createrows('1');\" readonly style=\" cursor:pointer;margin-left: 50px; text-transform:uppercase ; height: 40px; width:140px;text-align:center ; color:white ;background:green; border-style:ridge ;\" /></span></td>"
                   + "<td><span><input type=\"text\" value=\"Delete Row\" id=\"generate1\" class ='generate1' onclick=\"deleteRow('1');\" readonly style=\" cursor:pointer;margin-left: 50px; text-transform:uppercase ; height: 40px; width:170px;text-align:center ; color:white ;background:coral; border-style:ridge ;\" /></span></td>"
                     + "<td><a id='rmodal_trigger' style='page-break-before: avoid;color:red;background-color:white;margin:0px;' href='#rowsmodal' ><input type='text' value='Add Custom No of Rows' id='generate2'   readonly style='cursor:pointer;margin-left: 50px; text-transform:uppercase ; height: 40px; width:180px;text-align:center ; color:white ;background:#00CC00; border-style:ridge ;'/></a></td>"
                     + "<td><a id='delrows_trigger' style='page-break-before: avoid;color:red;background-color:white;margin:0px;' href='#delrowsmodal' ><input type='text' value='Delete Custom No of Rows' id='generate3'   readonly style='cursor:pointer;margin-left: 50px; text-transform:uppercase ; height: 40px; width:180px;text-align:center ; color:white ;background:#FF0000; border-style:ridge ;'/></a></td></tr></table>"
                    
                    + "<div style='overflow:scroll;'><table id='actionpointtable' name='actionpointtable'  style='overflow-y:scroll;width:1030px;padding-bottom:20px;margin-left:20px;margin-right:2px;margin-bottom:5px;height:97%;'  border='1'><tr><th><h4><b>SN</b></h4></th><th><h4><font color='red'><b>*</font>Follow up Actions recommended </b></h4></th><th><h4><font color='red'>*</font><b>Responsible person</b></h4></th><th><h4><font color='red'>*</font> <b>1st Expected <br/>Completion Date</b></h4></th><th><h4>2nd Expected <br/>Completion Date</h4></th></tr>";
           
           formedform+=addeddata;
            
            
             formedform+="</table></div><input type='hidden' name='counter' id='counter' value='"+counter+"'><input type='hidden' name='oldcounter' id='oldcounter' value='"+counter+"'></div>";
            
            
              if (conn.rs != null) {
                conn.rs.close();
            }
            if (conn.rs0 != null) {
                conn.rs0.close();
            }
            if (conn.rs_4 != null) {
                conn.rs_4.close();
            }
            if (conn.rs_6 != null) {
                conn.rs_6.close();
            }
            if (conn.st0 != null) {
                conn.st0.close();
            }
            if (conn.st != null) {
                conn.st.close();
            }
            if (conn.st_4 != null) {
                conn.st_4.close();
            }
            if (conn.st_6 != null) {
                conn.st_6.close();
            }
            

            try (PrintWriter out = response.getWriter()) {
                /* TODO output your page here. You may use following sample code. */

                out.println(formedform);
               // System.out.println("" + formedform);
            }
        } catch (SQLException ex) {
            Logger.getLogger(loadform1.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

   
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

 
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    //This function creates 
    
    
    
    public String createoptions(String designationid){
   String val="";
   
   for(int a=0;a<designationsAL.size();a++){
   if(designationid.equals(designationsALid.get(a))){
           val += "<option selected value=" + designationsALid.get(a) + ">" + designationsAL.get(a) + "</option>";
       } else {
           val += "<option value=" + designationsALid.get(a) + ">" + designationsAL .get(a)+ "</option>";
       }
   }
   
   
   
   return val;
    }
  
}
