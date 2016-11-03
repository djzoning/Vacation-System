<cfoutput>
	<div class="row" id="sortable_portlets">
		<div class="col-md-12">
			<div class="profile-sidebar">
				<div class="portlet light profile-sidebar-portlet ">
                    <!-- SIDEBAR USERPIC -->
                    <div class="profile-userpic">
                    	<cfif !IsNull(prc.user.getImage())>
	                    	<div class="userpic-loader">Loading...</div>
                    		<cfset imageUrl = "/users/getImage?image=#prc.user.getImage()#" />
                    	<cfelse>
                    		<cfset imageUrl = "/includes/images/no-user-image.png" />
                    	</cfif>
                        <a href="Users/editImage/#prc.user.getId()#" class="ajax-modal-btn">
                        	<img src="#imageUrl#" class="img-responsive" alt="">
                        </a>
                    </div>
                    <!-- END SIDEBAR USERPIC -->
                    <!-- SIDEBAR USER TITLE -->
                    <div class="profile-usertitle">
                        <div class="profile-usertitle-name"> #prc.user.getFirstName()# #prc.user.getLastName()# </div>
                        <div class="profile-usertitle-job"> #prc.user.getTeam().getName()# Team </div>
                    </div>
                    <!-- END SIDEBAR USER TITLE -->
                    <!-- SIDEBAR BUTTONS -->
                    <!---<div class="profile-userbuttons">
                        <button type="button" class="btn btn-circle green btn-sm">Follow</button>
                        <button type="button" class="btn btn-circle red btn-sm">Message</button>
                    </div>--->
                    <!-- END SIDEBAR BUTTONS -->
                    <!-- SIDEBAR MENU -->
                    <div class="profile-usermenu">
                        <!---<ul class="nav">
                            <li class="active">
                                <a href="">
                                    <i class="icon-home"></i>
                                    <span class="font-blue-soft"> Overview </span>
                                </a>
                            </li>
                            <li>
                                <a 	href="#event.buildLink('Users.edit.#prc.user.getId()#')#" 
									title = "Edit" 
									rel = "tooltip" 
									data-toggle = "modal" 
									data-target = "##responsive"
									class = "ajax-modal-btn"
								>
                                    <i class="icon-settings"></i> Edit </a>
                            </li>
                        </ul>--->
                    </div>
                    <!-- END MENU -->
                </div>
                <div class="portlet light ">
                    <!-- STAT -->
                    <div class="row">
                        <div class="col-md-3 col-sm-3 col-xs-6">
                            <div class="uppercase profile-stat-title"> #prc.user.getVacDays()# </div>
                            <div class="uppercase profile-stat-text font-blue-soft"> Remaining Paid</div>
                        </div>
                        <cfloop array="#prc.user.usedVacations#" index="usedVacation" >
	                        <div class="col-md-3 col-sm-3 col-xs-6">
	                            <div class="uppercase profile-stat-title"> #usedVacation.usedDays# </div>
	                            <div class="uppercase profile-stat-text font-blue-soft"> Used #usedVacation.name# </div>
	                        </div>
                        </cfloop>
                    </div>
                    <!-- END STAT -->
                </div>
                <!-- END PORTLET MAIN -->
			</div>
            <div class="profile-content">
            	<div class="row">
            		<div class="col-md-6 column sortable">
            			<div class="portlet portlet-sortable light">
            				<div class="portlet-title">
            					<div class="caption caption-md">
                                    <i class="icon-bar-chart theme-font hide"></i>
                                    <span class="caption-subject font-blue-soft bold uppercase">User Details</span>
                                    <span class="caption-helper hide"></span>
                                </div>
                                <div class="actions">
                                	<cfif SESSION.user.role EQ "Manager" OR SESSION.user.permissions.indexOf('IT') NEQ -1 OR SESSION.user.id EQ prc.user.getId()>
				                        #includeLink(
											href = 'Users.edit.#prc.user.getId()#',
											title = "Edit",
											name = "Edit",
											isModal = 1,
											icon = "fa fa-pencil",
											btnClass = "btn btn-default btn-sm"
										)#
				                    </cfif>
			                        <a class="btn btn-sm btn-icon-only btn-default fullscreen" href="javascript:;"></a>
			                    </div>
            				</div>
							<div class="portlet-body">
								<div class="row static-info">
			                        <div class="col-md-5 name">Name: </div>
			                        <div class="col-md-7 value">#prc.user.getFirstName()# #prc.user.getLastName()#</div>
			                    </div>
								<div class="row static-info">
			                        <div class="col-md-5 name">Username: </div>
			                        <div class="col-md-7 value">#prc.user.getUsername()#</div>
			                    </div>
								<div class="row static-info">
			                        <div class="col-md-5 name">Team: </div>
			                        <div class="col-md-7 value">#prc.user.getTeam().getName()#</div>
			                    </div>
								<div class="row static-info">
			                        <div class="col-md-5 name">Role: </div>
			                        <div class="col-md-7 value">#prc.user.getRole().getName()#</div>
			                    </div>
								<div class="row static-info">
			                        <div class="col-md-5 name">E-mail: </div>
			                        <div class="col-md-7 value">#prc.user.getEmail()#</div>
			                    </div>
							</div>
            			</div>
            			<div class="portlet portlet-sortable-empty"></div>
            		</div>
            		<div class="col-md-6 column sortable">
            			#runEvent(event ='dashboard.recentActivities', eventArguments = { widget = true, limit = 3 })#
            			<div class="portlet portlet-sortable-empty"></div>
					</div>
    			</div>
        		<!---End Row --->
        		<div class="row">
        			<div class="col-md-12 column sortable">
        				<div class="portlet portlet-sortable light">
            				<div class="portlet-title">
            					<div class="caption caption-md">
                                    <i class="icon-bar-chart theme-font hide"></i>
                                    <span class="caption-subject font-blue-soft bold uppercase">User Vacations</span>
                                    <span class="caption-helper hide"></span>
                                </div>
                                <div class="actions">
			                        <a class="btn btn-sm btn-icon-only btn-default fullscreen" href="javascript:;"></a>
			                    </div>
            				</div>
							<div class="portlet-body">
		            			<div class="table-responsive">
					                <table class="table table-striped table-bordered table-hover">
					                	<thead>
											<tr>
												<th class="text-center">From</th>
												<th class="text-center">To</th>
												<th class="text-center">Deputy</th>
												<th class="text-center">Type</th>
												<th class="text-center">Status</th>
												<th class="text-center">Description</th>
												<th class="text-center">Actions</th>
											</tr>
										</thead>
										<tbody>
											<cfloop array = "#prc.user.getVacations()#" index = "vacation">
												<tr>
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
															<a 
																href="#event.buildLink('Vacations.view.#vacation.getId()#')#" 
																title = "View" 
																rel = "tooltip" 
															>
																<i class = "glyphicon glyphicon-search"></i>
															</a>
														</div>
														<div class="col-md-1">
															<a 
																href="#event.buildLink('Vacations.edit.#vacation.getId()#')#" 
																title = "Edit" 
																rel = "tooltip" 
																data-toggle = "modal" 
																data-target = "##responsive"
																class = "ajax-modal-btn"
															>
																<i class = "glyphicon glyphicon-pencil"></i>
															</a>
														</div>
														<div class="col-md-1">
															<a 
																href = "#event.buildLink('Vacations.delete.#vacation.getId()#')#" 
																id = "delete-button" 
																data-toggle = "modal" 
																data-target = "##responsive"
																class = "ajax-modal-btn"
															>
																<i class = "glyphicon glyphicon-remove"></i>
															</a>
														</div>
													</td>
												</tr>
											</cfloop>
										</tbody>
					                </table>
					            </div>
            				</div>
        				</div>
        				<div class="portlet portlet-sortable-empty"></div>
        			</div>
        		</div>
        		<!---End Row --->
        	</div>
        	<!---End profile content --->
        </div>
	</div>
</cfoutput>
