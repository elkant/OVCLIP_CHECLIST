

<%@page import="database.dbConn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<%
//this is code to make sure the browser does not cache the pages
//and once logged out, session invalidated, send to login page
   

    if (session.getAttribute("userid") == null) {
        response.sendRedirect("index.htm");
    } 
%>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/all-1424208788.css' />" />
        <link rel="stylesheet" type="text/css" href="<c:url value='/menu/ovc lip user menu_files/css3menu1/style.css' />" /> 
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/js/css/start/jquery-ui-1.10.3.custom.css' />" />
        <link rel="stylesheet" type="text/css" href="<c:url value='/resources/select2/css/select2.css' />" />
        


        <!-------------------------------------------------------------------------------->
        <!-------------------------------------------------------------------------------->

        <link rel="stylesheet" href="<c:url value='/resources/css/font-awesome.min.css' />"  />
        <link type="text/css" rel="stylesheet"  href="<c:url value='/resources/css/style.css' />"  />
        <!-------------------------------------------------------------------------------->
        <!-------------------------------------------------------------------------------->

        <link rel="shortcut icon" href="<c:url value="/resources/images/favicon.png" />" type="image/x-icon"/>
        <title>Data Entry Form</title> 


    </head>
    <body>






        <div class="theme-changer">
            <div class="theme-inner">
             
                <div class="btn-group-vertical">
                    <br/>
                    <!--                    <a  href="dataentry.htm?t=sea" class="bt-sea btn btn-default">DeepSea</a>
                                            <a  href="dataentry.htm?t=sky" class="bt-sky btn btn-default">NightSky</a>
                                            <a  href="dataentry.htm?t=simple" class="bt-simple btn btn-default">Simple</a>
                                            <a  href="dataentry.htm?t=circle" class="bt-circle btn btn-default">Circle</a>-->
                    <a id="coutertotal" style="color:red;background-color: white;" href="#" class="btn"><h3><b>0</b> Rows</h3></a>
               
                    <a id="modal_trigger" style="color:red;background-color: white;width:127px;" href="#modal" class="btn"><img src="<c:url value="/resources/images/add.gif" />" /> Add Designation </a>
               </div>
            </div>
        </div>
        <style>
            .theme-changer {
                position: fixed;
                z-index: 9999;
                top: 55px;;
                left: 0;;
            }
            .theme-changer .headtext {
                font-size: 14px;
                font-weight: 700;
                color: #959595;
                text-transform: uppercase;
                letter-spacing: 1px;
                padding: 20px 0 15px 0;
                text-align: center;;
                background: rgba(255,255,255,0.5);
            }

           
            .nobr { white-space: nowrap }

            
        </style> 





        <div class="cont" style="width:1420px;">    
            <div style="font-size: 17px; margin-left: 10%;">

                <% if (session.getAttribute("level") != null) {
                        if (session.getAttribute("level").equals("2")) {
                %>
                <%@include file="../../menu/admin.jsp"%>

                <%} else {%>
                <%@include file="../../menu/user.jsp"%>
                <%}
    }%>

            </div>

            
            <div class="container" id="container1">


                <h4 style="text-align: center;background: orange;">Data Entry</h4>


                <div class="body-content">





                </div>
            </div>









            <footer class="footer">
                <div class="container">

                    <img src="<c:url value="/resources/images/loading.gif" />" class="loading" style="display:none;" /> 

                    <img src="<c:url value="/resources/images/wait2.gif" />" class="loading1" style="display:none;" /> 

                    
                    <div class="row" id="rw">
                        <div class="col-md-12">


                            <form id="wizard-example-5" action="" data-parsley-validate>
                                <fieldset>
                                    <legend id="ab">Background Information</legend>
                                    <div class="row">
                                        <div class="col-lg-6"> 
                                        
                    <div class='form-group'>
                    <label for='exampleInputPassword6'>Date of Assesment</label>"
                    <input type='text' onchange='checkupdate();' class='form-control' name='ass_date' id='ass_date' >
                    </div>
                    
                   
                  
                   <div class="form-group">
                  <label for="exampleInputPassword6">Name of LIP/CBO</label>
                  <select class="form-control" onchange='loadsites1();' name="lip" id='lip' data-parsley-group='block0' required>
                  
                  </select>
                  </div>
                   
                  <div class="form-group">
                  <label for="exampleInputPassword6">Site Visited</label>
                  <select class="form-control" name="site" id='site' onchange='checkupdate();' data-parsley-group="block0" >
                  <option value=''>Select Site</option>
                  </select>
                  </div>
                                            
                                            
                                        </div>
                                      </div>
                                </fieldset>
                              </form>
                        </div>
                    </div>

<%

                dbConn conn= new dbConn();
                String getcategories="select * from staff_roles ";
               String opts="<option value=''>select category</option>";
               String cbolists="<option value=''>select cbo</option>";
conn.rs=conn.st.executeQuery(getcategories);
while(conn.rs.next()){

opts+="<option value='"+conn.rs.getString(1)+"'>"+conn.rs.getString(2)+"</option>";

}

String getcbo="select * from cbo";
conn.rs1=conn.st1.executeQuery(getcbo);
while(conn.rs1.next()){
cbolists+="<option value='"+conn.rs1.getString(1)+"'>"+conn.rs1.getString(2)+"</option>";

}


%>


                    <div id="modal" class="popupContainer" style="display:none;width:500px;">
                        <header class="popupHeader">
                          
                            <span class="header_title">Add APHIAplus Staff </span>
                            <span class="modal_close"><img src="<c:url value="/resources/images/close.png" />" width="24px"></i></span>
                            
                             <%
                            if (session.getAttribute("actionmsg") != null)  { %>
                                <script type="text/javascript"> 
                    
                    var n = noty({text: '<%=session.getAttribute("actionmsg")%>',
                        layout: 'center',
                        type: 'Error', 
                         timeout: 1800});
                    
                </script> <%
                
                session.removeAttribute("actionmsg");
                            }

                        %>
                            
                        </header>

                        <section class="popupBody" style="width:550px;">
                            <div class="add_staff">
                                 <form name="adddesination" id="adddesination" action='saveDesignation' style="width:350px;">
                                    
       
                                    
                                    
                                    <table>
                                        
                                        <tr><td>Designation</td>
                                            <td><input class="form-control" type="text" id="designation" name="designation"></td></td>
                                       <tr><td>
                                               <input type="reset" style="height:36px;width:100px;" value="reset fields">
                                           </td><td >
                                            
                                        <input type="text" value="Save" id="generate1" class ='modal_close' onclick="saveDesignation();" readonly style=" cursor:pointer;margin-left: 50px; text-transform:uppercase ; height: 50px; width:140px;text-align:center ; color:white ;background:coral; border-style:ridge ;" />
                        
                                                        
                                            </td><td><p id="msg"></p></td></tr>
                                    </table>   


                                </form>
                            </div>
                        </section>
                    </div>

                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        <div id="sitemodal" class="popupContainer" style="display:none;width:500px;">
                        <header class="popupHeader">
                          
                            <span class="header_title">Add A Site </span>
                            <span class="modal_close"><img src="<c:url value="/resources/images/close.png" />" width="24px"></i></span>
                        </header>

                        <section class="popupBody" style="width:550px;">
                            <div class="add_staff">
                                <form name="addsite" id="addsite" action='saveSite' style="width:350px;">
                                    
                                    <!---------------------------------------------------->
                                    <!------------------LOAD COUNTIES--------------------->
                                    
                                    <!---------------------------------------------------->
                                    <%
                                    String counties="<option value=''>Select County</option>";
                                    
                                    String getcounty="select * from county";
                                    
                                    conn.rs=conn.st.executeQuery(getcounty);
                                    while(conn.rs.next()){
                                    counties+="<option value='"+conn.rs.getString(1)+"'>"+conn.rs.getString(2)+"</option>";
                                    
                                    }
                                    
                                    
                                    if(conn.st1!=null){conn.st1.close();}  
                                    if(conn.st!=null){conn.st.close();}  
                                    if(conn.rs!=null){conn.rs.close();}  
                                    if(conn.rs1!=null){conn.rs1.close();} 
                                    
                                    %>
                                    
                                    
                                    <table>
                                         <tr><td><span id="catlabel">Select County</td><td><select onchange='loaddistricts();' class="form-control" name="county" id="county"><%=counties%></select></td></td>
                                         <tr><td><span id="catlabel">Select District</td><td><select  class="form-control" name="district" id="district">select district</select></td></td>
                                      
                                        <tr><td><span style="" id="cbolabel">Cbo Name</span></td><td><select style="" class="form-control"   name="addcbo" id="addcbo" ><%=cbolists%></select></td></td>
                                        
                                        <tr><td>Site Name</td><td><input class="form-control" type="text" id="sitename" name="sitename"></td></td>
                                       <tr><td>  <input type="reset" style="height:36px;width:100px;" value="reset fields"></td><td >
                                            
                                        <input type="text" value="Save" id="generate1" class ='generate1' onclick="savesite();" readonly style=" cursor:pointer;margin-left: 50px; text-transform:uppercase ; height: 50px; width:140px;text-align:center ; color:white ;background:coral; border-style:ridge ;" />
                        
                                                        
                                            </td><td><p id="msg"></p></td></tr>
                                    </table>   


                                </form>
                            </div>
                        </section>
                    </div>
                                        
                                        
                                        
                 <div id="sitemodal" class="popupContainer" style="display:none;width:500px;">
                        <header class="popupHeader">
                          
                            <span class="header_title">Add A Designation </span>
                            <span class="modal_close"><img src="<c:url value="/resources/images/close.png" />" width="24px"></i></span>
                        </header>

                        <section class="popupBody" style="width:550px;">
                            <div class="add_staff">
                                <form name="adddesination" id="adddesination" action='saveDesignation' style="width:350px;">
                                    
       
                                    
                                    
                                    <table>
                                        
                                        <tr><td>Designation</td>
                                            <td><input class="form-control" type="text" id="designation" name="designation"></td></td>
                                       <tr><td>
                                               <input type="reset" style="height:36px;width:100px;" value="reset fields">
                                           </td><td >
                                            
                                        <input type="text" value="Save" id="generate1" class ='modal_close' onclick="saveDesignation();" readonly style=" cursor:pointer;margin-left: 50px; text-transform:uppercase ; height: 50px; width:140px;text-align:center ; color:white ;background:coral; border-style:ridge ;" />
                        
                                                        
                                            </td><td><p id="msg"></p></td></tr>
                                    </table>   


                                </form>
                            </div>
                        </section>
                    </div>
                                        
                                        
                   <div id="rowsmodal" class="popupContainer" style="display:none;width:500px;">
                        <header class="popupHeader">
                          
                            <span class="header_title">Enter Number of Rows To Add</span>
                            <span class="submitrows"><img src="<c:url value="/resources/images/close.png" />" width="24px"></i></span>
                        </header>

                        <section class="popupBody" style="width:550px;">
                            <div class="add_staff">
                                <form name="addrowsform" id="addrowsform" action='#' style="width:350px;">
                                    
       
                                    
                                    
                                    <table>
                                        
                                        <tr><td>No of Rows</td><td><input class="form-control" type="text" id="custrows" name="custrows"></td></td>
                                       <tr><td>  </td><td >
                                            
                                        <input type="text" value="ADD" id="submitrows" class ='submitrows' onclick="customrows();" readonly style=" cursor:pointer;margin-left: 50px; text-transform:uppercase ; height: 50px; width:140px;text-align:center ; color:white ;background:coral; border-style:ridge ;" />
                        
                                                        
                                            </td><td><p id="msg"></p></td></tr>
                                    </table>   


                                </form>
                            </div>
                        </section>
                    </div>                      
                                        
                      
                        
                            <div id="delrowsmodal" class="popupContainer" style="display:none;width:500px;">
                        <header class="popupHeader">
                          
                            <span class="header_title">Enter Number of Rows To Delete</span>
                            <span class="submitrows1"><img src="<c:url value="/resources/images/close.png" />" width="24px"></i></span>
                        </header>

                        <section class="popupBody" style="width:550px;">
                            <div class="add_staff">
                                <form name="delrowsform" id="delrowsform" action='#' style="width:350px;">
                                    
       
                                    
                                    
                                    <table>
                                        
                                        <tr><td>No of Rows</td><td><input class="form-control" type="text" id="delcustrows" name="delcustrows"></td></td>
                                       <tr><td>  </td><td >
                                            
                                        <input type="text" value="DELETE" id="submitrows1" class ='submitrows1' onclick="delcustomrows();" readonly style=" cursor:pointer;margin-left: 50px; text-transform:uppercase ; height: 50px; width:140px;text-align:center ; color:white ;background:coral; border-style:ridge ;" />
                        
                                                        
                                            </td><td><p id="msg"></p></td></tr>
                                    </table>   


                                </form>
                            </div>
                        </section>
                    </div> 
                                                
                                        
                                        
                </div>
            </footer>


            <script type="text/javascript" src='<c:url value="/resources/js/jquery-1.9.1.js" />'></script>
              
            <script type="text/javascript" src="<c:url value='/resources/js/all-1424208788.js' />"></script>
            <script type="text/javascript" src="<c:url value='/resources/js/bootstrap.js' />"></script>
            <script type="text/javascript" src="<c:url value='/resources/js/parsley.js' />"></script>
            <script type="text/javascript" src="<c:url value='/resources/js/js/jquery-ui-1.10.3.custom.js' />" /></script>
            <!--<script type="text/javascript" src="js/jquery-1.11.0.min.js"></script>-->
            <script type="text/javascript" src="<c:url value='/resources/js/jquery.leanModal.min.js' />" ></script>

            
            <script type="text/javascript" src="<c:url value='/resources/js/noty/jquery.noty.js' />"></script>
            <script type="text/javascript" src="<c:url value='/resources/js/noty/layouts/top.js' />"></script>
            <script type="text/javascript" src="<c:url value='/resources/js/noty/layouts/center.js' />"></script>
            <script type="text/javascript" src="<c:url value='/resources/js/noty/themes/default.js' />"></script>
          
       
            
            
            
        <script>
            
            var rfr=null;
            //$(window).load(function(){
            //    
            //});
            
            
             //$('.loading').show();
                $.ajax({
                    url: 'loadcbos',
                    type: 'post',
                    dataType: 'html',
                    success: function (data) {
                        document.getElementById("lip").innerHTML = data;
                  }});

            $(function () {

              
                       rfr=  $("#wizard-example-5").stepFormWizard({
                            height: 'auto',
                            theme:'sky',
                              showNav:false,
                            nextBtn: $('<a class="next-btn sf-right sf-btn" href="#">NEXT</a>'),
                            prevBtn: $('<a class="prev-btn sf-left sf-btn" href="#">PREVIOUS</a>'),
                            finishBtn: $('<a class="finish-btn sf-right sf-btn" href="#"></a>'),
            onNext: function(i, wizard) {
            return $('form', wizard).parsley().validate('block' + i);
                                        },                
            onFinish: function (i, wizard) {
                                if ($('form', wizard).parsley().validate() == true) {
                                    var form = $('form', wizard).serialize();
           //$.getJSON('savedata', form, function (data) {wizard.html(data.html);});
                                    $('.loading1').show();
                                   //__________________________________________
                                   
                                   $.ajax({
  type: 'POST',
  url: '#',
  data:form,
  dataType: 'text',
  success: function(data) {
      
       $('.loading1').hide();
    //alert(data);
              var n = noty({text:"<h3>"+data+"</h3>",
                        layout: 'center',
                        type: 'Success',
                        timeout: 2800,
         animation: {
        open: {height: 'toggle'}, // jQuery animate function property object
        close: {height: 'toggle'}, // jQuery animate function property object
        easing: 'swing', // easing
        speed: 500 // opening & closing animation speed
    },
    callback: {
   
        afterShow: function() {
            location.href='editactionpoint.htm';
            
        }
    }
    
        }); 
    
  },
  error: function() {
    alert('Error occured');
  }
});
                                   //__________________________________________
                                   
            //return true;
                                }
                                else {
                                    return false;
                                }
                            }




                        });

                        $("#ass_date").datepicker({changeMonth: true, changeYear: true, yearRange: '2008:2015', dateFormat: 'yy-mm-dd', maxDate: new Date()});
 
                        $('.loading').hide();
                  
                  //  }

               // });

            });


            //loaddata();


      function determinefunction(val){
 
     //if the selected site is main, then set the controller of the input
     
     var receivedval=val.value;
    
     //main offices end with 9999. This is done during entry of sites.
     if(receivedval.endsWith("9999")){
        document.getElementById("domainsumfilter").value="domaintotal";
        enableskippables();
    }
    else {
      document.getElementById("domainsumfilter").value='partialdomaintotal';   
        disableskippables();
         }
    
                                  }//end of function for determining the formula to use in adding
                                  
                                  
                                  
 //==_____________________________________________________________________________________________                                 
                                  function disableskippables(){
  var allskips=document.getElementById("allskippables").value;     
   
    var skipelems=allskips.split("_");
    
     for(a=0;a<skipelems.length;a++){
         if(skipelems[a]!==""){
   var curelem="element_"+skipelems[a];
   var curcomment="comment"+skipelems[a];
   document.getElementById(curelem).disabled=true;
   document.getElementById(curcomment).disabled='disabled';  
   document.getElementById(curelem).required=false;
   //make required false
                              }
                                   }                                  
                                      
                                  }


 //==_____________________________________________________________________________________________
            
    
    //==_____________________________________________________________________________________________                                 
        function enableskippables(){
  var allskips=document.getElementById("allskippables").value;   
   //alert(allskips);
    var skipelems=allskips.split("_");    
     for(a=0;a<skipelems.length;a++){
         if(skipelems[a]!==""){
   var curelem="element_"+skipelems[a];
   var curcomment="comment"+skipelems[a];
   
   document.getElementById(curelem).disabled =false;
   document.getElementById(curcomment).disabled =false;
   document.getElementById(curelem).required=true;
         }
   //make required false
     }                                  
                                      
                                  }


 //==_____________________________________________________________________________________________
 
    
    
    function loadsites1(cboid)
            {
                       var cboname=document.getElementById("lip").value;
               
         $.ajax({
                    url: "loadsites?cbo="+cboname,
                    type: 'post',
                    dataType: 'html',
                    success: function (data) {
                        
                    document.getElementById("site").innerHTML=data;    
                        
                    }
                });
        

            }

            //=========ADDITION FUNCTIONS THAT SHOW THE PERCENTAGE PER DOMAIN
            var elementi = [];
            var elementivalues = [];
            
    //create a function to push elements only after loading an update form
    function pushelements(allele,allsubmitedvalue){
        
        elementi=allele.split("~");
        elementivalues=allsubmitedvalue.split("~");
        
      //elementi.push(ele);
                    //elementivalues.push(submitedvalue);  
        
    }        
    function N(num, places) { 
      return +(Math.round(num + "e+" + places)  + "e-" + places);
                       
                            }
            
            
            function domaintotal(val, ele, mark, domain) {
                //create two arrays. one to store sent elements and another to store the value.   
                //add the value together    
                var submitedvalue = val.value;
                var elementname = ele;
                var marks = N(mark,4);
                var domainid = domain;
//alert(document.getElementById("domainsumfilter").value);

if(document.getElementById("domainsumfilter").value==='domaintotal'){

//a special case for > , < and such comaprisons in javascript
//if the selected value begins with a > or a <, then on our arrays that store the pushed elements , we will storte a yes, but in our database, we will save a >..,or <.. or >=..


if(submitedvalue.indexOf(">")===0||submitedvalue.indexOf("<")===0){
    
  submitedvalue="Yes";  
    
}

                //alert(submitedvalue+" "+ele+" "+mark+" "+domain);
                //if value is a yes , then mark is +ve 1, 
                //if value is a no, a mark is -ve 1
                //if value is a blank, a mark is 0

                var markstosent = 0;
                if (submitedvalue ==='Yes') {

                    markstosent = "" + marks;
                }
                else if (submitedvalue ==='No') {

                    markstosent = "-" + marks;

                }
                else {
                    markstosent = "-" + marks;

                }


                //check the value that was previuosly added so as to know how to handle a case of editing
                //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                //if editing , then you need to load the 2 arrays here with values from the database per domain and question.

                //    ;) I just hope the array will be fast while searching

                if (elementi.indexOf(ele) === -1) {

           //alert(ele+"  just added now. It didnt exist");

                    // alert(elementi);


                    //alert(elementi.indexOf(ele));
                    elementi.push(ele);
                    elementivalues.push(submitedvalue);
                    //now call the functions that do the updating of the totals.
                    //nb Dont update the totals if the selected value is a No..
                    if (submitedvalue === 'Yes') {
                        domainsum(markstosent, domainid);
                        //totalsum(markstosent);
                    }



                }
                else {
                    
                   //  alert(ele+"  existed. Its being edited");
                    
                    //get the index of the element, then update the value that was there previously...  
                    var pos = elementi.indexOf(ele);
                    //if the current option/value and the previous one are differing, then do a subtraction

                    if (elementivalues[pos] === submitedvalue || (elementivalues[pos] === "" && submitedvalue === "No") || (elementivalues[pos] === "No" && submitedvalue === "")) {
                        //then dont do anything
//alert("No change::: existing value "+elementivalues[pos]+" __ while __ "+submitedvalue);
                    }
                    else {
                        
                        //alert("There is change::: existing value "+elementivalues[pos]+" __ and new value is__ "+submitedvalue);
                        //replace with new value
                        elementivalues[pos] = submitedvalue;
                        //expect a change in here
                        domainsum(markstosent,domainid);
                        //totalsum(markstosent);
                    }

                }


              // alert(submitedvalue);


            }//end of the most inportant if 
            }
//=====================================================================================
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

            function partialdomaintotal(val, ele, mark, domain) {
                //create two arrays. one to store sent elements and another to store the value.   
                //add the value together    
                var submitedvalue = val.value;
                var elementname = ele;
                var marks = N(mark,4);
                var domainid = domain;
if(document.getElementById("domainsumfilter").value==='partialdomaintotal'  ){
  

//enable disable for the skippable 
//$$$$$$$$$$ SOMETHING MUST BE DONE HERE 
//$$$$$$$$$$ SOMETHING MUST BE DONE HERE 
//$$$$$$$$$$ SOMETHING MUST BE DONE HERE 
//$$$$$$$$$$ SOMETHING MUST BE DONE HERE 
//$$$$$$$$$$ SOMETHING MUST BE DONE HERE 
//$$$$$$$$$$ SOMETHING MUST BE DONE HERE 
//$$$$$$$$$$ SOMETHING MUST BE DONE HERE 
//disable required field for some  
//a special case for > , < and such comaprisons in javascript
//if the selected value begins with a > or a <, then on our arrays that store the pushed elements , we will storte a yes, but in our database, we will save a >..,or <.. or >=..


if(submitedvalue.indexOf(">")===0||submitedvalue.indexOf("<")===0){
    
  submitedvalue="Yes";  
    
}

                //alert(submitedvalue+" "+ele+" "+mark+" "+domain);
                //if value is a yes , then mark is +ve 1, 
                //if value is a no, a mark is -ve 1
                //if value is a blank, a mark is 0

                var markstosent = 0;
                if (submitedvalue ==='Yes') {

                    markstosent = "" + marks;
                }
                else if (submitedvalue ==='No') {

                    markstosent = "-" + marks;

                }
                else {
                    markstosent = "-" + marks;

                }


                //check the value that was previuosly added so as to know how to handle a case of editing
                //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                //if editing , then you need to load the 2 arrays here with values from the database per domain and question.

                //    ;) I just hope the array will be fast while searching

                if (elementi.indexOf(ele) === -1) {

           //alert(ele+"  just added now. It didnt exist");

                    // alert(elementi);


                    //alert(elementi.indexOf(ele));
                    elementi.push(ele);
                    elementivalues.push(submitedvalue);
                    //now call the functions that do the updating of the totals.
                    //nb Dont update the totals if the selected value is a No..
                    if (submitedvalue === 'Yes') {
                        domainsum(markstosent, domainid);
                        //totalsum(markstosent);
                    }



                }
                else {
                    
                   //  alert(ele+"  existed. Its being edited");
                    
                    //get the index of the element, then update the value that was there previously...  
                    var pos = elementi.indexOf(ele);
                    //if the current option/value and the previous one are differing, then do a subtraction

                    if (elementivalues[pos] === submitedvalue || (elementivalues[pos] === "" && submitedvalue === "No") || (elementivalues[pos] === "No" && submitedvalue === "")) {
                        //then dont do anything
//alert("No change::: existing value "+elementivalues[pos]+" __ while __ "+submitedvalue);
                    }
                    else {
                        
                        //alert("There is change::: existing value "+elementivalues[pos]+" __ and new value is__ "+submitedvalue);
                        //replace with new value
                        elementivalues[pos] = submitedvalue;
                        //expect a change in here
                        domainsum(markstosent,domainid);
                        //totalsum(markstosent);
                    }

                }


              // alert(submitedvalue);

}//end of the mother if condition
            }

//=====================================================================================
//
//
//
//
//
//
//
//
//
//
  function staticdomaintotal(val, ele, mark, domain) {
                //create two arrays. one to store sent elements and another to store the value.   
                //add the value together    
                var submitedvalue = val;
                var elementname = ele;
               var marks = N(mark,4);
                var domainid =domain;

                //alert(submitedvalue+" "+ele+" "+mark+" "+domain);
                //if value is a yes , then mark is +ve 1, 
                //if value is a no, a mark is -ve 1
                //if value is a blank, a mark is 0

                var markstosent = 0;
                if (submitedvalue === 'Yes') {

                    markstosent = "" + marks;
                }
                else if (submitedvalue === 'No') {

                    markstosent = "-" + marks;

                }
                else {
                    markstosent = "-" + marks;

                }


                //check the value that was previuosly added so as to know how to handle a case of editing
                //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
                //if editing , then you need to load the 2 arrays here with values from the database per domain and question.

                //    ;) I just hope the array will be fast while searching

                if (elementi.indexOf(ele)=== -1) {



                    


                    //alert(elementi.indexOf(ele));
                    elementi.push(ele);
                    elementivalues.push(submitedvalue);
                    //now call the functions that do the updating of the totals.
                    //nb Dont update the totals if the selected value is a No..
                    if (submitedvalue === 'Yes') {
                        domainsum(markstosent, domainid);
                       // totalsum(markstosent);
                    }



                }
                else {
                    
                      
                    //get the index of the element, then update the value that was there previously...  
                    var pos = elementi.indexOf(ele);
                    //if the current option/value and the previous one are differing, then do a subtraction

                    if (elementivalues[pos] === submitedvalue || (elementivalues[pos] === "" && submitedvalue === "No") || (elementivalues[pos] === "No" && submitedvalue === "")) {
                        //then dont do anything

                    }
                    else {
                        //replace with new value
                        elementivalues[pos] = submitedvalue;
                        //expect a change in here
                        domainsum(markstosent, domainid);
                        //totalsum(markstosent);
                    }

                }





            }
//
//
//
//=====================================================================================

            function domainsum(marks, doma) {
                
                var newvalue = marks;
                var curvalue = document.getElementById("domaininput" + doma).value;
                if (curvalue === '') {

                    curvalue = 0;

                }
                //alert(newvalue+" "+curvalue)
                var ttl = parseFloat(newvalue) + parseFloat(curvalue);
               // alert(newvalue+" "+curvalue+" = "+ttl);
                //set the input text value and the display purpose variable too.                
                document.getElementById("domaininput" + doma).value = N(ttl,4);
                
                
                var percttl=ttl*100;
                percttl=N(percttl,0);
                document.getElementById("domain" + doma).innerHTML = percttl + "%";
                    totalsum();

                                           }



//            function totalsum(marks) {
//                var newvalue = marks;
//                var curvalue = document.getElementById("totalsum").value;
//                if (curvalue === '') {
//
//                    curvalue = 0;
//
//                }
//                var ttl = parseFloat(newvalue) + parseFloat(curvalue);
//                  document.getElementById("totalsum").value = ttl;
//                var perct=ttl*100;
//                perct=N(perct,0);
//                perct=perct/12;
//              perct=N(perct,0)
//                document.getElementById("agg_percentage").innerHTML = perct + "%";
//
//            }

        </script>

  <script type="text/javascript" language="en">
   function numbers(evt){
var charCode=(evt.which) ? evt.which : event.keyCode
if(charCode > 31 && (charCode < 48 || charCode>57))
return false;
return true;
}
//-->
</script> 



        <script type="text/javascript">
            $("#modal_trigger").leanModal({top: 200, overlay: 0.6, closeButton: ".modal_close"});
            $("#modal_trigger1").leanModal({top: 200, overlay: 0.6, closeButton: ".modal_close"});
            

            //	$(function(){
            //		// Calling Login Form
            //		$("#login_form").click(function(){
            //			//$(".social_login").hide();
            //			$(".user_login").show();
            //			return false;
            //		});
            //
            //		
            //
            //	})
            
            
            function loadsites(){
                var cboname=document.getElementById("staffcbo").value;
               
         $.ajax({
                    url: "loadsites?cbo="+cboname,
                    type: 'post',
                    dataType: 'html',
                    success: function (data) {
                        
                    document.getElementById("sitecbo").innerHTML=data;    
                        
                    }
                });
        
                
            }
            
            function savestaff(){
                var fname=document.getElementById("fname").value;
                var mname=document.getElementById("mname").value;
                var phone=document.getElementById("phone").value;
                var site=document.getElementById("sitecbo").value;
                
                if(fname===''){
                  showerror(fname);  
                  noerror(fname);
                  showalert("first name");
                             }
                else if(mname===''){
                    showerror(mname);  
                  noerror(mname);
                  showalert("Last name");                    
                    
                                    }
//                  else if(phone===''){
//                      
//                  showerror(phone);  
//                  noerror(phone);
//                  showalert("Phone Number");                    
//                    
//                                    }
                
//                 else if(site===''){                      
//                  showerror(site);  
//                  noerror(site);
//                  showselectalert("Site");                  
//                    
//                                    }
                                    else {
                                        
                                        
                                  $.ajax({
                    url: "saveStaff?fname="+fname+"&mname="+mname+"&phone="+phone+"&category="+site,
                    type: 'post',
                    dataType: 'html',
                    success: function (data) {
                        //now reload the staff list
                  //document.getElementById("msg").innerHTML=data;
                    var n = noty({text:"<h3>"+data+"</h3>",
                        layout: 'center',
                        type: 'Success',
                        timeout: 2800,
         animation: {
        open: {height: 'toggle'}, // jQuery animate function property object
        close: {height: 'toggle'}, // jQuery animate function property object
        easing: 'swing', // easing
        speed: 500 // opening & closing animation speed
    },
    callback: {
   
        afterShow: function() {
            
         document.getElementById("addStaff").reset();   
        }
    }
    
        });
                  
                  loadmembers();
                    
                
                        
                                          }
                                          });       
                                        
                                        
                                        
                                    }
                
            }
            
       
    //------------------------------------------------------------------   
    //------------------------------------------------------------------  
    //ADD STAFF 
    //------------------------------------------------------------------   
    //------------------------------------------------------------------   
    //------------------------------------------------------------------   
    
    
    
    
    
        function savesite(){
                var county=document.getElementById("county").value;
                var district=document.getElementById("district").value;
                var cbo=document.getElementById("addcbo").value;
                var site=document.getElementById("sitename").value;
                
                if(county===''){
                  showerror(county);  
                  noerror(county);
                showselectalert("County"); 
                             }
                             
              else if(district===''){
                  showerror(district);  
                  noerror(district);
                showselectalert("district"); 
                             }
                             
             else if(cbo===''){
                  showerror(cbo);  
                  noerror(cbo);
                showselectalert("cbo"); 
                             }
                             
                else if(site===''){
                    showerror(site);  
                  noerror(site);
                  showalert("Site Name");                    
                    
                                    }
//                  else if(phone===''){
//                      
//                  showerror(phone);  
//                  noerror(phone);
//                  showalert("Phone Number");                    
//                    
//                                    }
                
//                 else if(site===''){                      
//                  showerror(site);  
//                  noerror(site);
//                  showselectalert("Site");                  
//                    
//                                    }
                                    else {
                                        
                                        
                                  $.ajax({
                    url: "saveSite?county="+county+"&district="+district+"&cbo="+cbo+"&site="+site,
                    type: 'post',
                    dataType: 'html',
                    success: function (data) {
                        //now reload the staff list
                  //document.getElementById("msg").innerHTML=data;
                    var n = noty({text:"<h3>"+data+"</h3>",
                        layout: 'center',
                        type: 'Success',
                        timeout: 2800,
         animation: {
        open: {height: 'toggle'}, // jQuery animate function property object
        close: {height: 'toggle'}, // jQuery animate function property object
        easing: 'swing', // easing
        speed: 500 // opening & closing animation speed
    },
    callback: {
   
        afterShow: function() {
            
         document.getElementById("addsite").reset();   
        }
    }
    
        });
                  
                 // loadmembers();
                    
                
                        
                                          }
                                          });       
                                        
                                        
                                        
                                    }
                
            }
    
    
    
    
    
            
            function showerror(elem){
                
                        $("#"+elem).css("border-color","#FF0000");
                        $("#"+elem).css("background-color","#FFFFFF");             
                        $("#"+elem).slideToggle("slow",function() {});
                        $("#"+elem).slideToggle("slow",function() {});  
                                     }
            
             function noerror(elem){
                
                        $("#"+elem).css("border-color","#000000");
                        $("#"+elem).css("background-color","#FFFFFF");             
                                    }
                                    
             function showalert(name){
                 
                                   alert("Enter "+name);   
                                        
                                     }
                                    
           function showselectalert(name){
               
                                   alert("Enter "+name);     
                                         
                                         }
                                         
                                         function loadmembers(){
                                             
                                          $.ajax({
                    url: "loadStaff",
                    type: 'post',
                    dataType: 'html',
                    success: function (data) {
                        
                        //document.getElementById("staffpresent").innerHTML=data;
                        document.getElementById("teammembers").innerHTML=data;
                        document.getElementById("teamleader").innerHTML=data;
                     $('#teammembers').select2();
                        
                    }});   
                                             
                                             
                                         }
                                         
      //a function that checks whether entered data can be updated based on the date and site
                                         
         function checkupdate(){
         
             var dat=document.getElementById("ass_date").value;
             var site=document.getElementById("site").value;
             var quarters="";
             var year="";
             var cbo=document.getElementById("lip").value;
             if(site!==""&&dat!==""){
            var fulldates=dat.split("-");
      //we are working with quarterly and yearly date format          
if(fulldates[1]==="10"||fulldates[1]==="11"||fulldates[1]==="12"){ quarters="1";}
else if(fulldates[1]==="01"||fulldates[1]==="02"||fulldates[1]==="03"){ quarters="2";}
else if(fulldates[1]==="04"||fulldates[1]==="05"||fulldates[1]==="06"){ quarters="3";}
else if(fulldates[1]==="07"||fulldates[1]==="08"||fulldates[1]==="09"){ quarters="4";}
else{quarters="0";}
year=fulldates[0];
//now call an ajax function whose return
                 $.ajax({
                    url: "isdqaformupdateabe?site="+site+"&period="+quarters+"&year="+year,
                    type: 'post',
                    dataType: 'text',
                    success: function (data) {
                     var da=data.trim();   
                     if(da==="update"){
                       
                    loadupdateform(site,quarters,year,cbo); 
                     }  
                     else
                     {
                         
                         
                     }
                        
                        
                    }
            
        });

                 
             }
         }
             
      
    
    //check assesment type
               
         function loadassesments(){
         
             var dat=document.getElementById("ass_date").value;
             var site=document.getElementById("site").value;
             var quarters="";
             var year="";
             var cbo=document.getElementById("lip").value;
             if(site!==""&&dat!==""){
            var fulldates=dat.split("-");
      //we are working with quarterly and yearly date format          
if(fulldates[1]==="10"||fulldates[1]==="11"||fulldates[1]==="12"){ quarters="1";}
else if(fulldates[1]==="01"||fulldates[1]==="02"||fulldates[1]==="03"){ quarters="2";}
else if(fulldates[1]==="04"||fulldates[1]==="05"||fulldates[1]==="06"){ quarters="3";}
else if(fulldates[1]==="07"||fulldates[1]==="08"||fulldates[1]==="09"){ quarters="4";}
else{quarters="0";}
year=fulldates[0];
//now call an ajax function whose return
                 $.ajax({
                    url: "assesmentType?siteid="+site+"&quarter="+quarters+"&year="+year,
                    type: 'post',
                    dataType: 'text',
                    success: function (data) {
                    
                        
                        document.getElementById("asses_type").innerHTML=data;
                    }
            
        });

                 
             }
         }
    
    
    
    
    
    
    
    
    
    //function
    
    function loadupdateform(site,quarters,year,cbo){
        
          
                         //initialize an update ajax to load data for that element
                       // alert("load existing data asap");
                       $('.loading').show(); 
                        
            $.ajax({
                    url: "loadactionpoint?site="+site+"&period="+quarters+"&year="+year+"&cbo="+cbo,
                    type: 'post',
                    dataType: 'text',
                    success: function (data) {
                      //document.getElementsByClassName("sf-wizard").innerHTML=""; 
                     $('#rw').html("<div class='col-md-12'><form id='wizard-example-5' action=''><fieldset><legend id='ab'></legend><div class='row'></div></fieldset></form></div>");
                    // $("#container1").load(
                      document.getElementById("wizard-example-5").innerHTML=data; 
                     
                      
                     //variables that help in preloading
                    
                      //alert(alle);
                      
                      
                       $("#wizard-example-5").stepFormWizard({
                            height: 'number',
                           startStep:'1',
                            showNav:false,
                            theme:'sky',
                            nextBtn: $('<a class="next-btn sf-right sf-btn" href="#">NEXT</a>'),
                            prevBtn: $('<a class="prev-btn sf-left sf-btn" href="#">PREVIOUS</a>'),
                            finishBtn: $('<a class="finish-btn sf-right sf-btn" href="#">UPDATE</a>'),
                            onFinish: function (i, wizard) {
                                if ($('form', wizard).parsley().validate() == true) {
                                    var form = $('form', wizard).serialize();
                                    
                                   // $.getJSON('updatedata', form, function (data) {wizard.html(data.html);});
                                    
                                    
                                    
                                    
           //=================================================================================
           
            
            $('.loading1').show();
                                   //__________________________________________
                                   
                                   $.ajax({
  type: 'POST',
  url: 'updateactionpoint',
  data:form,
  dataType: 'text',
  success: function(data) {
      
       $('.loading1').hide();
    //alert(data);
              var n = noty({text:"<h3>"+data+"</h3>",
                        layout: 'center',
                        type: 'Success',
                        timeout: 2800,
         animation: {
        open: {height: 'toggle'}, // jQuery animate function property object
        close: {height: 'toggle'}, // jQuery animate function property object
        easing: 'swing', // easing
        speed: 500 // opening & closing animation speed
    },
    callback: {
   
        afterShow: function() {
            location.reload();
            
        }
    }
    
        }); 
    
  },
  error: function() {
    alert('Error occured');
  }
});
                                   //__________________________________________
                                   
            
            
           //=================================================================================                         
                                    
                                    
                                    
                                }
                                else {
                                    return false;
                                }
                            },
                            onNext: function (i, wizard) {
                                return $('form', wizard).parsley().validate('block' + i);
                            }




                        });

                        $("#ass_date").datepicker({changeMonth: true, changeYear: true, yearRange: '2008:2015', dateFormat: 'yy-mm-dd'});
                        $(".dates").datepicker({changeMonth: true, changeYear: true, yearRange: '2008:2015', dateFormat: 'yy-mm-dd'});
                      $("#rmodal_trigger").leanModal({top: 200, overlay: 0.6, closeButton: ".submitrows"});
                           $("#delrows_trigger").leanModal({top: 200, overlay: 0.6, closeButton: ".submitrows1"});
                        $('.loading').hide();
                       document.getElementById("coutertotal").innerHTML="<h3><b>"+document.getElementById("counter").value+" Rows</b></h3>"; 
                       
                        
                    }         
            
            });
        
        
    }
    
    
    function togglesites(){
        
         if(document.getElementById("position").value=='2'){
             
             document.getElementById("cbolabel").innerHTML='Cbo';
             document.getElementById("staffcbo").style.display='block';
             
             document.getElementById("sitelabel").innerHTML='Site';
             document.getElementById("sitecbo").style.display='block';
             
         }
         else{
             document.getElementById("staffcbo").value="";
             document.getElementById("cbolabel").innerHTML='';
             document.getElementById("staffcbo").style.display='none';
             
             document.getElementById("sitelabel").innerHTML='';
             document.getElementById("staffcbo").value="";
             document.getElementById("sitecbo").style.display='none';
             
         }
        
        
        
        
    }
        
    
$(document).keyup(function(event){

if((event.which== 13) && ($(event.target)[0]!=$("textarea")[0])) {
console.log("dont submit");
    }
    else{
    console.log("submit");
    }

});
    
    
    function loaddistricts(){
    var cnt=document.getElementById("county").value;
    
    
        $.ajax({
                    url: "loaddistrict?county="+cnt,
                    type: 'post',
                    dataType: 'html',
                    success: function (data) {
                        
                    document.getElementById("district").innerHTML=data;    
                        
                    }
                }); 
        
    }
    
    
    function invokedisable(curelem){
   //invoke a onchange on the parent element so that previously disabled elements will still be disabled based on the value that has been entered at the parent (controller) element   
      $("#"+curelem).change();   
        
    }
    
    
    
    
     function loaddes(rw){
          
          
        $.ajax({
                    url: "loaddesignation",
                    type: 'post',
                    dataType: 'html',
                    success: function (data) {
                        
                  document.getElementById("select"+rw).innerHTML=data;  
                        
                    }
                });
      }  
      
    function customrows(){
     var noofrows=document.getElementById("custrows").value;
     createrows(noofrows);
     document.getElementById("custrows").value="";   
    }
    
    function delcustomrows(){
     var noofrows=document.getElementById("delcustrows").value;
     deleteRow(noofrows);
     document.getElementById("delcustrows").value="";   
    }
    
  
  function createrows(num){
   for( a=0;a<num;a++){  
 var allrows=document.getElementById("counter").value;
allrows=parseInt(allrows)+1;
 var rws2=allrows;

   document.getElementById("counter").value=rws2;
document.getElementById("coutertotal").innerHTML="<h3><b>"+rws2+"</b> Rows</h3>";
var tbl = document.getElementById('actionpointtable');
var lastRow=tbl.rows.length;
//alert(lastRow);
var x=document.getElementById('actionpointtable').insertRow(lastRow);
//now insert columns

var y=x.insertCell(0);
var z=x.insertCell(1);
var v=x.insertCell(2);
var b=x.insertCell(3);
var c=x.insertCell(4);
//var m=x.insertCell(4);

loaddes(rws2);
y.innerHTML="<h3>"+rws2+"</h3>";
z.innerHTML="<div class='form-group'><Textarea rows='2' cols='30' class='form-control' name='actionid"+rws2+"' id='actionid"+rws2+"' ></TextArea></div>";
v.innerHTML="<div class='form-group'><select name='select"+rws2+"' class='form-control' id='select"+rws2+"'></select></div>";
b.innerHTML="<div class='form-group'><input class='form-control' type='text' id='fdate"+rws2+"' name='fdate"+rws2+"'></div>";
c.innerHTML="<div class='form-group'><input class='form-control' type='text' id='sdate"+rws2+"' name='sdate"+rws2+"'></div>";
   
        $("#fdate"+rws2).datepicker({changeMonth: true, changeYear: true, yearRange: '2008:2015', dateFormat: 'yy-mm-dd'});
        $("#sdate"+rws2).datepicker({changeMonth: true, changeYear: true, yearRange: '2008:2015', dateFormat: 'yy-mm-dd'});
                        
        }
   
rfr.refresh();
//var sfw = $("#wizard_example").stepFormWizard();
//sfw.refresh();
   //now call the wizard method again

      
  }
  //===================end of Adding Rows====================
    
    
    
    
    //delete rows
    function deleteRow(num)
{
   
    //alert(num+"___maxdel is:"+maxdeletable)
     for( a=0;a<num;a++){
          var currowsno=parseInt(document.getElementById("counter").value);
    var maxdeletable=parseInt(document.getElementById("oldcounter").value);
    if(currowsno>maxdeletable){
   
    var all_rows=document.getElementById("counter").value;
 
     if(all_rows==="1"){
     //dont delete   
    }
    else{
    var rws2=all_rows-1;
    if(rws2<0){
        //dont go beyond 0
       rws2=0 ;
    }
document.getElementById('actionpointtable').deleteRow(all_rows);
document.getElementById("counter").value=rws2;
document.getElementById("coutertotal").innerHTML="<h3><b>"+rws2+"</b> Rows</h3>";
}

}
    }
rfr.refresh();
}
    
    
    
    
    
          function saveDesignation(){
                var designation=document.getElementById("designation").value;
               
                
                if(designation===''){
                  showerror(designation);  
                  noerror(designation);
                  showalert("Designation");
                             }
               
//                  else if(phone===''){
//                      
//                  showerror(phone);  
//                  noerror(phone);
//                  showalert("Phone Number");                    
//                    
//                                    }
                
//                 else if(site===''){                      
//                  showerror(site);  
//                  noerror(site);
//                  showselectalert("Site");                  
//                    
//                                    }
                                    else {
                                        
                                        
                                  $.ajax({
                    url: "saveDesignation?dis="+designation,
                    type: 'post',
                    dataType: 'html',
                    success: function (data) {
                        
                        var msgs=data.trim().split("@");
                    
                        //get the just added option and value and append to each select 
                        var opts=msgs[1].split("%");
    
$('select').append("<option value="+opts[0]+" >"+opts[1]+"</option>");
                        
                        //now reload the staff list
                  document.getElementById("designation").value="";
                    var n = noty({text:"<h3>"+msgs[0]+"</h3>",
                        layout: 'center',
                        type: 'Success',
                        timeout: 2800,
         animation: {
        open: {height: 'toggle'}, // jQuery animate function property object
        close: {height: 'toggle'}, // jQuery animate function property object
        easing: 'swing', // easing
        speed: 500 // opening & closing animation speed
    },
    callback: {
   
        afterShow: function() {
            
        // document.getElementById("addStaff").reset();   
        }
    }
    
        });
                  
                  //loadmembers();
                    
                
                        
                                          }
                                          });       
                                        
                                        
                                        
                                    }
                
            }
           
    
    
        </script>

<script type="text/javascript" src="<c:url value='/resources/select2/js/select2.js' />"></script>


    </div>
</body>

</html>
