/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;


import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.Trigger;
import org.quartz.TriggerBuilder;
import org.quartz.impl.StdSchedulerFactory;

/**
 *
 * @author Maureen
 */
public class InternetThread extends HttpServlet {

    HttpSession session=null;
    
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       
        session=request.getSession();
        
        System.out.println("SESSION RUNNINGSTATUS IS ::_"+session.getAttribute("runningstatus"));
        
        
            response.setContentType("text/html;charset=UTF-8");
                           
           if(session.getAttribute("runningstatus")!=null){
           
           //dont call the thread. It means there is a running status
           }
           
           else {
            
           if(StartThread(false).equals("running")){
           
           
           session.setAttribute("runningstatus", "running");
           
           
           }

           }
            
            PrintWriter out = response.getWriter();
            try {
                /* TODO output your page here. You may use following sample code. */               
out.println("</html>");
            } finally {
                out.close();
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
    
    
    public String StartThread( boolean shutdown){
    System.out.println("StartThread is running__");
      int jobprefix=0;
    
    try {
        JobDetail syndatajob = JobBuilder.newJob(SYNCEXCECUTER.class).withIdentity("OVCSYNCSCHEDULER"+jobprefix).build();
        SchedulerFactory schFactory = new StdSchedulerFactory();
        Scheduler sch = schFactory.getScheduler();
        sch.start();
        
        
        //=========whether to stop scheduler or start===============
        
     //scheduler.deleteJob(jobKey("job1", "group1"));
        // Unschedule a particular trigger from the job (a job may have more than one trigger)
       //scheduler.unscheduleJob(triggerKey("trigger1", "group1"));
            
        
        
        
        
        
        
 
// 
//    //loop all group
//    for (String groupName : sch.getJobGroupNames()) {
// 
//	//loop all jobs by groupname
//	for (String jobName : sch.getJob) {
// 
//          //get job's trigger
//	  Trigger[] triggers = sch.getTriggersOfJob(jobName,groupName);
//	  Date nextFireTime = triggers[0].getNextFireTime();
// 
//	  System.out.println("[jobName] : " + jobName + " [groupName] : "
//			+ groupName + " - " + nextFireTime);
// 
//	}
// 
//    }
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
            if (shutdown==true) {
               
                // realtimesmsjob = null;
                if (!sch.getCurrentlyExecutingJobs().isEmpty()) {
                }
                
                sch.shutdown(shutdown);
//after a shutdown, revert the statements to true
                sch.shutdown(false);
                
            }
            
            
            else if(shutdown==false){
               
            }
      
        
//=======================end of start or stop scheduler======================
        
//===============================MONTHLY EXPECTED DELIVERY DATE===============================
        
//second minute hour am/pm
        
        CronTrigger syncTrigger = TriggerBuilder.newTrigger().withIdentity("ovcsynctrigger"+jobprefix, "ovcsynctriggergroup"+jobprefix).withSchedule(CronScheduleBuilder.cronSchedule("0 0/3 * * * ?")) // .withSchedule(CronScheduleBuilder.cronSchedule("0 26 8a * * ?"))
                .build(); 
        if (!sch.isShutdown()) {
            sch.scheduleJob(syndatajob, syncTrigger);
        }
    } catch (SchedulerException ex) {
        Logger.getLogger(InternetThread.class.getName()).log(Level.SEVERE, null, ex);
    }

return "running";
    
    }
}
