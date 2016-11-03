<cfoutput>
	<div class="row">
		<div class="col-md-6">
			<div class="portlet box blue">
				<div class="portlet-title">
		            <div class="caption">
		                <i class="fa fa-bars"></i>
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
									<th class="text-center">Names</th>
									<th class="text-center">Max Days</th>
									<th class="text-center">Actions</th>
								</tr>
							</thead>
							<tbody>
				
								<cfloop array="#prc.VacationType#" index="properties">
									<tr>
										<td>#properties.getName()#</td>
										<td class="text-center">#properties.getDaysLimit()#</td>
										<td class="align-center">
											<div class="col-md-1">
												#includeLink(
													href = 'VacationTypes.edit.#properties.getId()#',
													title = "Edit",
													isModal = 1,
													icon = "glyphicon glyphicon-pencil",
													btnClass = ""
												)#
											</div>
											<div class="col-md-1">
												#includeLink(
													href = 'VacationTypes.delete.#properties.getId()#',
													title = "Delete",
													isModal = 1,
													icon = "glyphicon glyphicon-remove",
													btnClass = ""
												)#
											</div>
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
