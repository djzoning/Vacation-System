<cfoutput>
	<div id="sortable_portlets" class="row ui-sortable">
		<div class="col-md-6 col-sm-6 column sortable">
			<!--- Quick actions --->
			#runEvent(event = 'dashboard.quickActions', eventArguments = { widget = true })#
			
			<!--- Vacations --->
		    #runEvent(event = 'dashboard.vacations', eventArguments = { widget = true })#

		    <div class="portlet portlet-sortable-empty"></div>
		</div>
		
		<div class="col-md-6 col-sm-6 column sortable">
			<!--- User activities --->
			#runEvent(event = 'dashboard.recentActivities', eventArguments = { widget = true, limit = 10 })#
			
			<cfif SESSION.user.role EQ "Team Lead">
				<cfinclude template="partials/teamLead_index.cfm">
			</cfif>

			<cfif SESSION.user.role EQ "Manager">
				<cfinclude template="partials/manager_index.cfm">
			</cfif>

		    <div class="portlet portlet-sortable-empty"></div>
		</div>
	</div>
</cfoutput>