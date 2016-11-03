<cfoutput>
	<ul class="page-sidebar-menu  page-header-fixed page-sidebar-menu-hover-submenu " data-keep-expanded="false" data-auto-scroll="true" data-slide-speed="200">
	    <li class="nav-item start" data-handler="dashboard">
	        <a href="#event.buildLink('Main.index')#" class="nav-link nav-toggle">
	            <i class="icon-home"></i>
	            <span class="title">Dashboard</span>
	            <span class="arrow"></span>
	        </a>
	    </li>
	    <li class="nav-item" data-handler="calendar">
	        <a href="#event.buildLink('Calendar.index')#" class="nav-link nav-toggle">
	            <i class="icon-calendar"></i>
	            <span class="title">Calendar</span>
	            <span class="arrow"></span>
	        </a>
	    </li>
	    <li class="nav-item" data-handler="vacations">
	        <a href="#event.buildLink('Vacations.index')#" class="nav-link nav-toggle">
	            <i class="icon-globe"></i>
	            <span class="title">Vacations</span>
	            <span class="arrow"></span>
	        </a>
	    </li>
	    <li class="nav-item" data-handler="users">
	        <a href="#event.buildLink('Users.index')#" class="nav-link nav-toggle">
	            <i class="icon-user"></i>
	            <span class="title">Users</span>
	            <span class="arrow"></span>
	        </a>
	    </li>
	    
	    <cfif SESSION.user.role EQ "Manager" OR SESSION.user.permissions.indexOf('IT') != -1>
		    <cfinclude template="partials/mainMenu_admin.cfm">
	    </cfif>
	</ul>
</cfoutput>