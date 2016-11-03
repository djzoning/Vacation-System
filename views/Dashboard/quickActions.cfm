<cfoutput>
	<div class="portlet portlet-sortable light ">
		<div class="portlet-title tabbable-line">
		    <div class="caption">
		        <i class=" icon-social-twitter font-dark hide"></i>
		        <span class="caption-subject font-dark bold uppercase">Quick Actions</span>
		    </div>
		    <ul class="nav nav-tabs">
		        <li class="active">
		            <a href="##tab_actions_pending" data-toggle="tab" aria-expanded="true"> Pending </a>
		        </li>
		        <li class="">
		            <a href="##tab_actions_completed" data-toggle="tab" aria-expanded="false"> Completed </a>
		        </li>
		    </ul>
		</div>

		<div id="dashboard-quick-actions" class="portlet-body">
		    <div class="tab-content">
		        <div class="tab-pane active" id="tab_actions_pending">
		            <!-- BEGIN: Pending Actions -->
		            <div class="mt-actions">
		                <cfset prc.tabType = "pending">
		                <cfset prc.requests = prc.requestsPending>
						<cfinclude template="partials/_quickActions.cfm">
		            </div>
		            <!-- END: Actions -->
		        </div>

		        <div class="tab-pane" id="tab_actions_completed">
		            <!-- BEGIN:Completed-->
		            <div class="mt-actions">
		                <cfset prc.requests = prc.requestsCompleted>
		                <cfset prc.tabType = "completed">
						<cfinclude template="partials/_quickActions.cfm">
		            </div>
		        </div>
		    </div>
		</div>
	</div>
</cfoutput>