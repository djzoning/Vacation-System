<cfoutput>
	<li class="divider"> </li>
	<li>
		<a href="#event.buildLink('Users.create')#" title="Create User" data-target="##responsive" class = "ajax-modal-btn">
	  		<i class="icon-user"></i> User 
		</a>
	</li>
	<li>
		<a href="#event.buildLink('Teams.create')#" title="Create Team" data-target="##responsive" class = "ajax-modal-btn">
	  		<i class="icon-users"></i> Team 
		</a>
	</li>
	<li>
		<a href="#event.buildLink('Roles.create')#" title="Create Role" data-target="##responsive" class = "ajax-modal-btn">
	  		<i class="icon-star"></i> Role 
		</a>
	</li>
	<li>
		<a href="#event.buildLink('VacationTypes.create')#" title="Create Vacation Type" data-target="##responsive" class = "ajax-modal-btn">
	  		<i class="icon-layers"></i> Vacation Type
		</a>
	</li>
</cfoutput>