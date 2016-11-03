<cfoutput>
	#getModel( "messagebox@cbmessagebox" ).renderit()#
	<div class="row">
		<div class="col-md-12">
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
									<td class="text-center">ID</td>
									<th class="text-center">Names</th>
									<!--- <th class="text-center">Actions</th> --->
								</tr>
							</thead>
							<tbody>
								<!--- <cfdump var="#prc#" /> --->
								<cfloop array="#prc.VacationStatus#" index="properties">
									<tr>
										<td class="text-center">#properties.getId()#</td>
										<td>#properties.getName()#</td>
										<!--- <td class="text-center"> --->
										<!--- 	<div class="col-md-1 col-md-offset-5">
												<a href="" data-toggle="modal" data-target="##responsive">
													<i class = "glyphicon glyphicon-pencil"></i>
												</a>
											</div>
											<div class="col-md-1">
												<a href = "">
													<i class = "glyphicon glyphicon-remove"></i>
												</a>
											</div> --->
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