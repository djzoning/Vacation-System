<cfoutput>
	<div class="row">
		<div class="col-md-12">
			<div class="portlet box blue">
				<div class="portlet-title">
		            <div class="caption">
		                <i class="fa fa-globe"></i>
		                <span class="caption-subject font-white sbold">Vacations</span>
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
									<th class="text-center">User</th>
									<th class="text-center">From</th>
									<th class="text-center">To</th>
									<th class="text-center">Fill-in</th>
									<th class="text-center">Type</th>
									<th class="text-center">Status</th>
									<th class="text-center">Description</th>
									<th class="text-center">Actions</th>
								</tr>
							</thead>
							<tbody>
								<cfloop array = "#prc.vacations#" index = "vacation">
									<tr>
										<td>#vacation.getUser().getFirstName()#</td>
										<td class="text-center">#DateFormat(vacation.getFromDate(), "mm/dd/yy")#</td>
										<td class="text-center">#DateFormat(vacation.getToDate(), "mm/dd/yy")#</td>
										<td>#vacation.getDeputy().getFirstName()#</td>
										<td class="text-center">#vacation.getType().getName()#</td>
										<td class="text-center">#vacation.getStatus().getName()#</td>
										<td>
											<cfif Len(vacation.getDescription()) GT 20>
												#Left(vacation.getDescription(), 20)# ...
											<cfelse>
												#vacation.getDescription()#
											</cfif>
										</td>
										<td class="align-center">
											<div class="col-md-1">
												#includeLink(
													href = 'Vacations.view.#vacation.getId()#',
													title = "View",
													icon = "glyphicon glyphicon-search",
													btnClass = ""
												)#
											</div>
											<cfif vacation.getUser().getId() EQ SESSION.user.id>
												<div class="col-md-1">
													#includeLink(
														href = 'Vacations.edit.#vacation.getId()#',
														title = "Edit",
														isModal = 1,
														icon = "glyphicon glyphicon-pencil",
														btnClass = ""
													)#
												</div>
												<div class="col-md-1">
													#includeLink(
														href = 'Vacations.delete.#vacation.getId()#',
														title = "Delete",
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
