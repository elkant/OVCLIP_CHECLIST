<%@page import="java.util.Calendar"%>
<%@page import="database.dbConn"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html">
<html>
    <head>
        <title>OVC LIP</title>
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
            
            
        <script src="<c:url value="/resources/js/cufon-yui.js" />" type="text/javascript"></script>
        <script src="<c:url value="/resources/js/ChunkFive_400.font.js" />" type="text/javascript"></script>
	
            
        
        <script type="text/javascript">
			Cufon.replace('h1',{textShadow: '1px 1px #fff'});
			Cufon.replace('h2',{textShadow: '1px 1px #fff'});
			Cufon.replace('h3',{textShadow: '1px 1px #000'});
			Cufon.replace('.back');
		</script>
                
                
                <script>
                
                
                

if(!('contains' in String.prototype)) {
       String.prototype.contains = function(str, startIndex) {
                return -1 !== String.prototype.indexOf.call(this, str, startIndex);
       };
 }


                
                
                    $.ajax({
                        url:'InternetThread',                         
                    type:'post',  
                    dataType: 'html',  
                    success: function(data) {
                     
                             var n = noty({text:"Data Syncing",
                        layout: 'top',
                        type: 'Success',
                        timeout: 7800,
        animation: {
        open: {height: 'toggle'}, // jQuery animate function property object
        close: {height: 'toggle'}, // jQuery animate function property object
        easing: 'swing', // easing
        speed: 500 // opening & closing animation speed
                   }            
        }); 
                    }
                        
                         });
//                         
                         
                          function checkVersion(){
//    CHECK Version------------------- 
$("#version").html("<p>Checking for newer Version...</p>");
var versionText="",daysRemaining,warningText="",sentOn="",version_name="";
 $.ajax({
                    url:"version",
                    type:'post',
                    dataType:'html',
                    success:function (data){
                        if(data.trim()==="no_internet"){
                          $("#versionChecker").html  ("<p style='color: blue; font-size:10px;'>Unable to check if there is a newer version of DIC system due to limited or no internet connection.</p>");
      setInterval(function(){ checkVersion(); }, 60000);          
        }
                        else{
                            
                            
                      if(data.contains("outdated version")){
                          $("#container").hide();   
                      }
$("#versionChecker").html(data);
                        }
  }  
  });   
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
        
		<div class="wrapper" >
                  
			<h1 style="font-size:40px;text-align: center;"><span>OVC LIP SUPERVISION CHECKLIST</span></h1>
			<br/>
			<br/>
			<div class="content">
				<div id="form_wrapper" class="form_wrapper">
					<form class="register">
						<h3>Register</h3>
						<div class="column">
							<div>
								<label>First Name:</label>
								<input type="text" />
								<span class="error">This is an error</span>
							</div>
							<div>
								<label>Last Name:</label>
								<input type="text" />
								<span class="error">This is an error</span>
							</div>
							<div>
								<label>Website:</label>
								<input type="text" value="http://"/>
								<span class="error">This is an error</span>
							</div>
						</div>
						<div class="column">
							<div>
								<label>Username:</label>
								<input type="text"/>
								<span class="error">This is an error</span>
							</div>
							<div>
								<label>Email:</label>
								<input type="text" />
								<span class="error">This is an error</span>
							</div>
							<div>
								<label>Password:</label>
								<input type="password" />
								<span class="error">This is an error</span>
							</div>
						</div>
						<div class="bottom">
							<div class="remember">
								<input type="checkbox" />
								<span>Send me updates</span>
							</div>
							<input type="submit" value="Register" />
							<a href="index.html" rel="login" class="linkform">You have an account already? Log in here</a>
							<div class="clear"></div>
						</div>
					</form>
					<form class="login active" action="login" style="width:400px;">
						<h3>Login</h3>
						<div>
							<label>Username:</label>
							<input type="text" name="uname" required />
							<span class="error">This is an error</span>
						</div>
						<div>
							<label>Password: 
                                                            
                                                        <!--<a href="forgot_password.html" rel="forgot_password" class="forgot linkform">Forgot your password?</a>-->
                                                        
                                                        </label>
							<input type="password" name="pass" />
							<span class="error">This is an error</span>
						      </div>
						<div class="bottom">
							<!--<div class="remember"><input type="checkbox" /><span>Keep me logged in</span></div>-->
							<input type="submit" value="Login"></input>
							<!--<a href="register.jsp.html" rel="register" class="linkform">You don't have an account yet? Register here</a>-->
							<div class="clear"></div>
						</div>
					</form>
					<form class="forgot_password">
						<h3>Forgot Password</h3>
						<div>
							<label>Username or Email:</label>
							<input type="text" />
							<span class="error">This is an error</span>
						</div>
						<div class="bottom">
							<input type="submit" value="Send reminder"></input>
							<a href="index.html" rel="login" class="linkform">Suddenly remembered? Log in here</a>
							<a href="register.jsp.html" rel="register" class="linkform">You don't have an account? Register here</a>
							<div class="clear"></div>
						</div>
                                                
                                               
					</form>
				</div>
                            <div class="clear"></div>
                            <br/>
                            <br/>
                             <h3 align="center"> <img src="<c:url value='resources/images/aphia_logo.png' />" alt="logo" height="86px" width="270px"/></h3>
                                                
				<div class="clear"></div>
			</div>
                             <br/>
                             <br/>
                             
                             <%
               Calendar cal = Calendar.getInstance();
               int year= cal.get(Calendar.YEAR); 
                                 
              dbConn conn= new dbConn();
              conn.rs=conn.st.executeQuery("select version_name , date_updated from version order by version_id desc limit 1");          
              while(conn.rs.next()){
%>
                             
                             <div class="footer"><h2 style="text-align: center;"> &copy <a href="#" title="<%=conn.rs.getString(1)%> compiled on <%=conn.rs.getString(2)%>">OVC LIP SUPERVISION SYSTEM</a> Aphia Plus | USAID <%=year%> </h2> </div>
                             <% } 
                               conn.rs.close();
conn.st.close();

                             %>
                              <div id="versionChecker" style="font-weight: bolder; text-align:center;">
                         </div><br>
                             
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
                        
                        
                        checkVersion();
        </script>
        </div>
    </body>
</html>