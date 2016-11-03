<cfoutput>
	<ul class="dropdown-menu" role="menu">
	    <li>
			<a href="#event.buildLink('Vacations.create')#" title="Create Vacation" data-target="##responsive" class = "ajax-modal-btn">
		  		<i class="icon-globe"></i> Vacation
			</a>
	    </li>
	    <cfif SESSION.user.role EQ "Manager" OR SESSION.user.permissions.indexOf('IT') != -1>
		    <cfinclude template="partials/newItemMenu_admin.cfm">
	    </cfif>
	</ul>
</cfoutput>