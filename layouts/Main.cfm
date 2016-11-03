
<cfoutput>
#html.doctype()#
<!---
Template Name: /includes/theme/assets - Responsive Admin Dashboard Template build with Twitter Bootstrap 3.3.6
Version: 4.5.6
Author: KeenThemes
Website: http://www.keenthemes.com/
Contact: support@keenthemes.com
Follow: www.twitter.com/keenthemes
Dribbble: www.dribbble.com/keenthemes
Like: www.facebook.com/keenthemes
Purchase: http://themeforest.net/item/includes/theme/assets-responsive-admin-dashboard-template/4021469?ref=keenthemes
Renew Support: http://themeforest.net/item/includes/theme/assets-responsive-admin-dashboard-template/4021469?ref=keenthemes
License: You must have a valid license purchased only from themeforest(the above link) in order to legally use the theme for your project.
--->
<!--[if IE 8]> <html lang="en" class="ie8 no-js"> <![endif]-->
<!--[if IE 9]> <html lang="en" class="ie9 no-js"> <![endif]-->
<!--[if !IE]><!-->

<html lang="en">
    <!---<![endif]--->
    <!--- BEGIN HEAD --->

    <head>
        <meta charset="utf-8" />
        <title>#prc.title#</title>
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta content="width=device-width, initial-scale=1" name="viewport" />
        <meta content="" name="description" />
        <meta content="" name="author" />

		<!---Base URL --->
		<base href="#getSetting("HTMLBaseURL")#" />
		

        <!-- BEGIN GLOBAL MANDATORY STYLES -->
        <link href="http://fonts.googleapis.com/css?family=Open+Sans:400,300,600,700&subset=all" rel="stylesheet" type="text/css" />
        <link href="/includes/theme/assets/global/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
        <link href="/includes/theme/assets/global/plugins/simple-line-icons/simple-line-icons.min.css" rel="stylesheet" type="text/css" />
        <link href="/includes/theme/assets/global/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
        <link href="/includes/theme/assets/global/plugins/bootstrap-switch/css/bootstrap-switch.min.css" rel="stylesheet" type="text/css" />
        <link href="/includes/theme/assets/global/plugins/bootstrap-toastr/toastr.min.css" rel="stylesheet" type="text/css">
        <!-- END GLOBAL MANDATORY STYLES -->
        
        <link href="/includes/theme/assets/global/plugins/bootstrap-modal/css/bootstrap-modal-bs3patch.css" rel="stylesheet" type="text/css" />
        <link href="/includes/theme/assets/global/plugins/bootstrap-modal/css/bootstrap-modal.css" rel="stylesheet" type="text/css" />
        <link href="/includes/theme/assets/global/plugins/jcrop/css/jquery.Jcrop.min.css" rel="stylesheet" type="text/css" />
		
        <link href="/includes/fullcalendar-2.2.7-yearview/fullcalendar.min.css" rel="stylesheet" type="text/css" />    
        <!--- DATERANGEPICKER --->
		<link href="/includes/theme/assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.css" rel="stylesheet" type="text/css" />
        <!--- SELECT 2 --->
        <link href="/includes/theme/assets/global/plugins/select2/css/select2.min.css" rel="stylesheet" type="text/css" />
		
        <!-- BEGIN THEME GLOBAL STYLES -->
        <link href="/includes/theme/assets/global/css/components-rounded.min.css" rel="stylesheet" id="style_components" type="text/css" />
        <link href="/includes/theme/assets/global/css/plugins.min.css" rel="stylesheet" type="text/css" />
        <!-- END THEME GLOBAL STYLES -->
        
        <link href="/includes/theme/assets/pages/css/profile.min.css" rel="stylesheet" type="text/css" />
        <!-- BEGIN THEME LAYOUT STYLES -->
        <link href="/includes/theme/assets/layouts/layout2/css/layout.min.css" rel="stylesheet" type="text/css" />
        <link href="/includes/theme/assets/layouts/layout2/css/themes/blue.min.css" rel="stylesheet" type="text/css" id="style_color" />
        <link href="/includes/theme/assets/layouts/layout2/css/custom.min.css" rel="stylesheet" type="text/css" />
        <link href="/includes/theme/assets/global/plugins/icheck/skins/all.css" rel="stylesheet" type="text/css" />
        <!--- <link href="/includes/theme/assets/global/plugins/icheck/skins/polaris/polaris.css" type="text/javascript" /> --->
        
        <link href="/css/style.css" rel="stylesheet" type="text/css" />
        
        <!-- END THEME LAYOUT STYLES -->
        <link rel="shortcut icon" href="favicon.ico" />
    </head>
    <!-- END HEAD -->

    <body class="page-header-fixed page-sidebar-closed-hide-logo page-container-bg-solid page-footer-fixed page-sidebar-fixed">
        <!-- BEGIN HEADER -->
        <div class="page-header navbar navbar-fixed-top">
            <!-- BEGIN HEADER INNER -->
            <div class="page-header-inner ">
                <!-- BEGIN LOGO -->
                <div class="page-logo">
                    <a href="/">
                        <img src="../includes/images/logo-13bik_105x30.png" alt="13 BIK logo" class="logo-default" width="75" /> </a>
                    <div class="menu-toggler sidebar-toggler">
                        <!-- DOC: Remove the above "hide" to enable the sidebar toggler button on header -->
                    </div>
                </div>
                <!-- END LOGO -->
                <!-- BEGIN RESPONSIVE MENU TOGGLER -->
                <a href="javascript:;" class="menu-toggler responsive-toggler" data-toggle="collapse" data-target=".navbar-collapse"> </a>
                <!-- END RESPONSIVE MENU TOGGLER -->
                <!-- BEGIN PAGE ACTIONS -->
                <!-- DOC: Remove "hide" class to enable the page header actions -->
				
				<!---Begin New Item Menu --->
                <div class="page-actions">
                    <div class="btn-group">
                        <button type="button" class="btn btn-circle btn-outline red dropdown-toggle" data-toggle="dropdown">
                            <i class="fa fa-plus"></i>&nbsp;
                            <span class="hidden-sm hidden-xs">New&nbsp;</span>&nbsp;
                            <i class="fa fa-angle-down"></i>
                        </button>
                        #runEvent(event='NewItemMenu.list', prepostExempt=true)#
                    </div>
                </div>
				<!---End New Item Menu --->

                <!-- END PAGE ACTIONS -->
                <!-- BEGIN PAGE TOP -->
                <div class="page-top">
                    <!-- BEGIN TOP NAVIGATION MENU -->
                    <div class="top-menu">
                        <ul class="nav navbar-nav pull-right">
                            <!-- BEGIN NOTIFICATION DROPDOWN -->
                            <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                            <!--- #runEvent('main.notificationDropdown')# --->
                            <!-- END NOTIFICATION DROPDOWN -->
                            <!-- BEGIN INBOX DROPDOWN -->
                            <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                            #runEvent('main.inboxDropdown')#
                            <!-- END INBOX DROPDOWN -->
                            
                            <!-- BEGIN USER LOGIN DROPDOWN -->
                            <!-- DOC: Apply "dropdown-dark" class after below "dropdown-extended" to change the dropdown styte -->
                            #runEvent('main.userLoginDropdown')#
                            <!-- END USER LOGIN DROPDOWN -->
                        </ul>
                    </div>
                    <!-- END TOP NAVIGATION MENU -->
                </div>
                <!-- END PAGE TOP -->
            </div>
            <!-- END HEADER INNER -->
        </div>
        <!-- END HEADER -->
        <!-- BEGIN HEADER & CONTENT DIVIDER -->
        <div class="clearfix"> </div>
        <!-- END HEADER & CONTENT DIVIDER -->
        <!-- BEGIN CONTAINER -->
        <div class="page-container">
            <!-- BEGIN SIDEBAR -->
            <div class="page-sidebar-wrapper">
                <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
                <!-- DOC: Change data-auto-speed="200" to adjust the sub menu slide up/down speed -->
				<!---Begin Main Menu --->
                <div class="page-sidebar navbar-collapse collapse">
                    <!-- DOC: Apply "page-sidebar-menu-light" class right after "page-sidebar-menu" to enable light sidebar menu style(without borders) -->
                    <!-- DOC: Apply "page-sidebar-menu-hover-submenu" class right after "page-sidebar-menu" to enable hoverable(hover vs accordion) sub menu mode -->
                    <!-- DOC: Apply "page-sidebar-menu-closed" class right after "page-sidebar-menu" to collapse("page-sidebar-closed" class must be applied to the body element) the sidebar sub menu mode -->
                    <!-- DOC: Set data-auto-scroll="false" to disable the sidebar from auto scrolling/focusing -->
                    <!-- DOC: Set data-keep-expand="true" to keep the submenues expanded -->
                    <!-- DOC: Set data-auto-speed="200" to adjust the sub menu slide up/down speed -->

					#runEvent(event='MainMenu.list', prepostExempt=true)#
                </div>
				<!---End Main Manu --->
            </div>
            <!-- END SIDEBAR -->

            <!-- BEGIN CONTENT -->
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                    <!-- BEGIN PAGE HEADER-->
                    <!-- BEGIN THEME PANEL -->
                    <div class="theme-panel"></div>
                    <!-- END THEME PANEL -->
                    <h3 class="page-title">#prc.title#
                        <small>#prc.smallTitle#</small>
                    </h3>
                    <div class="page-bar">
                        <ul class="page-breadcrumb"></ul>
                        <div class="page-toolbar">
                            <div class="btn-group pull-right">
                                <button type="button" class="btn btn-fit-height grey-salt dropdown-toggle" data-toggle="dropdown" data-hover="dropdown" data-delay="1000" data-close-others="true"> Actions
                                    <i class="fa fa-angle-down"></i>
                                </button>
                                <ul class="dropdown-menu pull-right" role="menu">
                                    <li>
                                        <a href="##">
                                        <i class="icon-bell"></i> Action</a>
                                    </li>
                                    <li>
                                        <a href="##">
                                        <i class="icon-shield"></i> Another action</a>
                                    </li>
                                    <li>
                                        <a href="##">
                                        <i class="icon-user"></i> Something else here</a>
                                    </li>
                                    <li class="divider"> </li>
                                    <li>
                                        <a href="##">
                                        <i class="icon-bag"></i> Separated link</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--- END PAGE HEADER --->

					<!--- CONTAINER AND VIEWS  --->
					#getModel( "messagebox@cbmessagebox" ).renderit()#
					#renderView()#

                </div>
                <!--- END CONTENT BODY --->
            </div>
            <!--- END CONTENT --->
        </div>
        <!--- END CONTAINER --->
        <!--- BEGIN FOOTER --->
        <div class="page-footer">
            <div class="page-footer-inner"> 2016 &copy; Vacations by
                <a href="http://13bik.com" title="13 BIK" target="_blank"> 13 BIK.</a>
            </div>
            <div class="scroll-to-top">
                <i class="icon-arrow-up"></i>
            </div>
        </div>
		
		<!--- MODAL --->
		<div id="responsive" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true" data-width="760">
			<div class="modal-content">
			</div>	
	    </div>
		
        <!--- END FOOTER --->
        <!--[if lt IE 9]>
		<script src="/includes/theme/assets/global/plugins/respond.min.js"></script>
		<script src="/includes/theme/assets/global/plugins/excanvas.min.js"></script> 
		<![endif]-->

        <!--- JS --->
        <script src="/includes/theme/assets/global/plugins/jquery.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/moment.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/icheck/icheck.min.js" type="text/javascript"></script>
        <script src="/includes/fullcalendar-2.2.7-yearview/fullcalendar.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/bootstrap-daterangepicker/daterangepicker.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/select2/js/select2.full.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/jcrop/js/jquery.Jcrop.min.js" type="text/javascript"></script>
        <script src="/js/Calendar.js"></script>
        <script src="/js/UserValidator.js"></script>
        <script src="/js/script.js"></script>

        <!-- BEGIN CORE PLUGINS -->
        <script src="/includes/theme/assets/global/plugins/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/js.cookie.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/bootstrap-hover-dropdown/bootstrap-hover-dropdown.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/jquery-slimscroll/jquery.slimscroll.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/jquery.blockui.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/bootstrap-switch/js/bootstrap-switch.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
        <!--- END CORE PLUGINS --->
        <script src="/includes/theme/assets/global/plugins/bootstrap-modal/js/bootstrap-modal.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/bootstrap-modal/js/bootstrap-modalmanager.js" type="text/javascript"></script>
		<script src="/includes/theme/assets/pages/scripts/ui-extended-modals.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/jquery-ui/jquery-ui.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/global/plugins/bootstrap-toastr/toastr.min.js" type="text/javascript"></script>
		
        <!--- BEGIN THEME GLOBAL SCRIPTS --->
        <script src="/includes/theme/assets/global/scripts/app.min.js" type="text/javascript"></script>
        <!--- END THEME GLOBAL SCRIPTS --->
		<script src="/includes/theme/assets/pages/scripts/portlet-draggable.min.js" type="text/javascript"></script>
        <!--- BEGIN THEME LAYOUT SCRIPTS --->
        <script src="/includes/theme/assets/layouts/layout2/scripts/layout.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/layouts/layout2/scripts/demo.min.js" type="text/javascript"></script>
        <script src="/includes/theme/assets/layouts/global/scripts/quick-sidebar.min.js" type="text/javascript"></script>
        <!--- END THEME LAYOUT SCRIPTS --->
    </body>
</html>
</cfoutput>
