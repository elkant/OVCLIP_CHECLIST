/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package data;

import java.io.IOException;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

/**
 *
 * @author Emmanuel E
 */
public class SYNCEXCECUTER implements Job {

    //this is the primary status that will be used to check whether syncing is going on.
    public static boolean syncingstatus;
    // A variable to shows whether the checking of internet presence is already running
    //true means checking is ongoing
    public static boolean netcheckingstatus;
    public static String pagecalled="no";
    
    @Override
    public void execute(JobExecutionContext jec) throws JobExecutionException {
   //check for internet connection
    
        System.out.println("__Sync Executer has been called");
        startorendthread();
        
        //Check for internet connection
        //check for ongoing merging
        
    
    }
    
 
    
    
    public String  startorendthread() {

        
       String  msg="@@@no msg";
       int a = 0;

        if(pagecalled.equals("no")){            
        pagecalled="yes";    
    
                a++;
                System.out.println(" a is +++++++ ;"+a);
                if (syncingstatus==false) {
                    if (testInet("google.com") || testInet("twitter.com") || testInet("amazon.com")) {                       
                        System.out.println("_Internet Connection available.Calling merging page once!");
                        syncdata sd= new syncdata();
                        if(sd.doSyncing()==true){
                            msg="Data Saved Online";
                            netcheckingstatus=false;
                            
                            if (a>=1) {
                                System.out.println("_Stopping timer to wait for syncing to finish");
                                pagecalled="no";
                                //_t.cancel();  // Terminates this timer, discarding any currently scheduled tasks.
                                //_t.purge();
                                
                            }
                            //make page called to be zero here
                            
                            
                            //********************************************************
                            //********************************************************

                            
                        }
                          
                      

                    } else {
          //keep on checking for internet connection
                           netcheckingstatus=true;
                        msg="No Internet Connection";
                        System.out.println("No Internet connection but timer is listening");
          //dont stop the cycle
                    }

        //in here., check whether an app is running
                                                } 
                else {
                 
                    System.out.println("Syncing is ongoing and thus timer has been stopped");                    

                }
                

            }
       
        pagecalled="no";
        return msg;
    }

    public static boolean testInet(String site) {
        Socket sock = new Socket();
        InetSocketAddress addr = new InetSocketAddress(site, 80);
        try {
            sock.connect(addr, 3000);
            return true;
        } catch (IOException e) {
            return false;
        } finally {
            try {
                sock.close();
            } catch (IOException e) {
            }
        }
    }
    


    
    
    
}
