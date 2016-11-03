<cfoutput>
	<div class="row">
		<div class="col-md-12">
			<div class="portlet box blue">
				<div class="portlet-title">
		            <div class="caption">
		                <i class="fa fa-user"></i>
		                <span class="caption-subject font-white sbold">#prc.title#</span>
		            </div>
		            <div class="tools">
		                <a href="javascript:;" class="reload"> </a>
		                <a href="javascript:;" class="collapse"> </a>
		            </div>
		        </div>
		        <div class="portlet-body">
		            <div class="table-responsive">
		            	<table class="table table-striped table-bordered table-hover">
		            		<thead>
		            			<tr>
		            				<th class="text-center">ID</th>
		            				<th class="text-center">First Name</th>
		            				<th class="text-center">Last Name</th>
		            				<th class="text-center">E-mail</th>
		            				<th class="text-center">Actions</th>
		            			</tr>
		            		</thead>
							<tbody>
								<cfloop array="#prc.users#" index="user">
									<tr>
										<td class="text-center">#user.getId()#</td>
										<td>#user.getFirstName()#</td>
										<td>#user.getLastName()#</td>
										<td>#user.getEmail()#</td>
										<td class="align-center">
											<div class="col-md-1">
												#includeLink(
													href = 'Users.view.#user.getId()#',
													title = "View",
													icon = "glyphicon glyphicon-search",
													btnClass = ""
												)#
											</div>
											<cfif SESSION.user.role EQ "Manager" OR SESSION.user.permissions.indexOf('IT') NEQ -1>
												<div class="col-md-1">
													#includeLink(
														href = 'Users.edit.#user.getId()#',
														title = "Edit",
														isModal = 1,
														icon = "glyphicon glyphicon-pencil",
														btnClass = ""
													)#
												</div>
												<div class="col-md-1">
													#includeLink(
														href = 'Users.delete.#user.getId()#',
														title = "View",
														isModal = 1,
														icon = "glyphicon glyphicon-remove",
														btnClass = ""
													)#
												</div>
											</cfif>
										</td>
									</tr>
								</cfloop>
							</tbody>
						</table>
		            </div>
		        </div>
			</div>
		</div>
	</div>
</cfoutput>
