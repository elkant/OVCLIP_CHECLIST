<%@page import="java.util.Calendar"%>
<%@page import="database.dbConn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html">
<html>
    <head>
        <title>Web Chart Reports (Excel)</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
       	<link rel="shortcut icon" href="<c:url value="/resources/images/favicon.png" />" type="image/x-icon"/>
        <link rel="stylesheet" type="text/css" href="<c:url value="/resources/css/newstyle.css"/>" />
        <script type="text/javascript" src="<c:url value="/resources/js/jquery-1.9.1.js"/>"></script>
         <script type="text/javascript" src="<c:url value='/resources/js/noty/jquery.noty.js' />"></script>
            <script type="text/javascript" src="<c:url value='/resources/js/noty/layouts/top.js' />"></script>
            <script type="text/javascript" src="<c:url value='/resources/js/noty/layouts/center.js' />"></script>
            <script type="text/javascript" src="<c:url value='/resources/js/noty/themes/default.js' />"></script>
            <!--tooltip-->
            <link href="<c:url value='resources/js/css/start/jquery-ui-1.10.3.custom.css' />" rel="stylesheet"/>
	
            <script src="<c:url value='resources/js/js/jquery-ui-1.10.3.custom.js' />"></script>
             <link rel="stylesheet" href="<c:url value="/menu/ovc lip user menu_files/css3menu1/style.css" />" /> 
       
            
        <script src="<c:url value="/resources/js/cufon-yui.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/ChunkFive_400.font.js" />" type="text/javascript"></script>
	
            
        
        <script type="text/javascript">
			Cufon.replace('h1',{textShadow: '1px 1px #fff'});
			Cufon.replace('h2',{textShadow: '1px 1px #fff'});
			Cufon.replace('h3',{textShadow: '1px 1px #000'});
			Cufon.replace('.back');
   
    
     function loadcbos()
            {
                      // var cboname=document.getElementById("lip").value;
            
        var year=document.getElementById("year").value;
        
         $.ajax({
                    url: "loadrreportcbos?year="+year,
                    type: 'post',
                    dataType: 'html',
                    success: function (data) {
                     document.getElementById("staffcbo").innerHTML=data;     
                        
                    }
                });
        

            }
    
    
                   
    
    
    
                         function loadsites()
            {
                       var cboname=document.getElementById("staffcbo").value;
                         var year=document.getElementById("year").value;
                         var period=document.getElementById("period").value;
         $.ajax({
                    url: "loadreportsites?cbo="+cboname+"&year="+year+"&period="+period,
                    type: 'post',
                    dataType: 'html',
                    success: function (data) {
                        
                    document.getElementById("sitecbo").innerHTML=data;    
                        
                    }
                });
        

            }

              
    function changeAction() {

                var curaction = document.getElementById("reporttype").value;

                document.getElementById("formid").action = curaction;


            }
    
                        
		</script>
    </head>
    <body >
        
           <%
                            if (session.getAttribute("error_login") != null)  { %>
                                <script type="text/javascript"> 
                    
                    var n = noty({text: '<%=session.getAttribute("error_login")%>',
                        layout: 'center',
                        type: 'Error', 
                         timeout: 1800});
                    
                </script> <%
                
                session.removeAttribute("error_login");
                            }

                        %>
        
        
        <div class="cont">
                
<div class="header" style="margin-left: 10%;margin-right: 2px;">
    <br/>
       
                <% if (session.getAttribute("level") != null) {
                        if (session.getAttribute("level").equals("2")) {
                %>
                <%@include file="../../menu/admin.jsp"%>

                <%} else {%>
                <%@include file="../../menu/user.jsp"%>
                <%}
    }%>                  
</div>
		<div class="wrapper" >
                  
			<h2 style="text-align: center;"><span>OVC LIP SUPERVISION IP/CBO REPORTS </span></h2>
			<br/>
			<br/>
			<div class="content">
				<div id="form_wrapper" class="form_wrapper">
					
					<form class="login active" action="barCharts" id="formid" style="width:400px;">
						<h3>Enter the start and end date </h3>
				
                                        
                                        <div class="column">  
                                        
                                         
                                         <div>
  <label><b>(1) Start Date</b><font color="red">  *</font></label>
  <input type="text" style="width:280px;" readonly required class="form-control"  name="startdate" id="startdate" > 
                                        
                                        </div>  
                                            
                                            <div>
                                                
                                        <label><b>(2) End Date</b><font color="red">  *</font></label>
                                        <input type="text" style="width:280px;" required class="form-control"  name="enddate" id="enddate" >
                                           <br/>
                                        </div> 
                                        
                                        
                                        
                                        </div>
                                        <div class="bottom">
							<!--<div class="remember"><input type="checkbox" /><span>Keep me logged in</span></div>-->
							<input type="submit" value="Generate"></input>
							<!--<a href="register.jsp.html" rel="register" class="linkform">You don't have an account yet? Register here</a>-->
							<div class="clear"></div>
						</div>
						
					</form>
					
				</div>
                            <div class="clear"></div>
                            <br/>
                            <br/>
                                            
				<div class="clear"></div>
			</div>
                             <br/>
                             <br/>
                             
      
                          
				</div>
		

		<!-- The JavaScript -->
		<!--<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>-->
		<script type="text/javascript">
			$(function() {
					//the form wrapper (includes all forms)
				var $form_wrapper	= $('#form_wrapper'),
					//the current form is the one with class active
					$currentForm	= $form_wrapper.children('form.active'),
					//the change form links
					$linkform		= $form_wrapper.find('.linkform');
						
				//get width and height of each form and store them for later						
				$form_wrapper.children('form').each(function(i){
					var $theForm	= $(this);
					//solve the inline display none problem when using fadeIn fadeOut
					if(!$theForm.hasClass('active'))
						$theForm.hide();
					$theForm.data({
						width	: $theForm.width(),
						height	: $theForm.height()
					});
				});
				
				//set width and height of wrapper (same of current form)
				setWrapperWidth();
				
				/*
				clicking a link (change form event) in the form
				makes the current form hide.
				The wrapper animates its width and height to the 
				width and height of the new current form.
				After the animation, the new form is shown
				*/
				$linkform.bind('click',function(e){
					var $link	= $(this);
					var target	= $link.attr('rel');
					$currentForm.fadeOut(400,function(){
						//remove class active from current form
						$currentForm.removeClass('active');
						//new current form
						$currentForm= $form_wrapper.children('form.'+target);
						//animate the wrapper
						$form_wrapper.stop()
									 .animate({
										width	: $currentForm.data('width') + 'px',
										height	: $currentForm.data('height') + 'px'
									 },500,function(){
										//new form gets class active
										$currentForm.addClass('active');
										//show the new form
										$currentForm.fadeIn(400);
									 });
					});
					e.preventDefault();
				});
				
				function setWrapperWidth(){
					$form_wrapper.css({
						width	: $currentForm.data('width') + 'px',
						height	: $currentForm.data('height') + 'px'
					});
				}
				
				/*
				for the demo we disabled the submit buttons
				if you submit the form, you need to check the 
				which form was submited, and give the class active 
				to the form you want to show
				*/
				$form_wrapper.find('input[type="submit"]')
							 .click(function(e){
								//e.preventDefault();
							 });	
			});
                             
    document.getElementById("formid").reset(); 
      $("#startdate").datepicker({changeMonth: true, changeYear: true, yearRange: '2008:2015', dateFormat: 'yy-mm-dd', maxDate: new Date()});
      $("#enddate").datepicker({changeMonth: true, changeYear: true, yearRange: '2008:2015', dateFormat: 'yy-mm-dd', maxDate: new Date()});
                  
        </script>
        </div>
    </body>
</html>