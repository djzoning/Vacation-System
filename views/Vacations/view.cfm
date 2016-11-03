<cfoutput>
    #html.hiddenField(name = "maxAllowedPaidAlert", id = "maxAllowedPaidAlert", value = "#prc.maxAllowedPaidAlert#")#
    #html.hiddenField(name = "teamUsersAlert", id = "teamUsersAlert", value = "#prc.teamUsersAlert#")#
    #html.hiddenField(name = "vacationTypeLengthAlert", id = "vacationTypeLengthAlert", value = "#prc.vacationTypeLengthAlert#")#
    #html.hiddenField(name = "vacationLengthAlert", id = "vacationLengthAlert", value = "#prc.vacationLengthAlert#")#

    <div id = "alerts-container-view"></div>
	<div class="row">
		<div class="col-md-6 column sortable">
			<div class="portlet portlet-sortable light">
                <div class="portlet-title">
                    <div class="caption caption-md">
                        <span class="caption-subject font-blue-soft bold uppercase">#prc.title#</span>
                        <span class="caption-helper hide"></span>
                    </div>
                    <div class="actions">
                        <cfif prc.vacation.getUser().getId() EQ SESSION.user.id>
                            #includeLink(
    							href = 'Vacations.edit.#prc.vacation.getId()#',
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
                        <div class="col-md-7 value">#prc.vacation.getUser().getFirstName()#</div>
                    </div>
                	<div class="row static-info">
                        <div class="col-md-5 name">Team: </div>
                        <div class="col-md-7 value">#prc.vacation.getUser().getTeam().getName()#</div>
                    </div>
                	<div class="row static-info">
                        <div class="col-md-5 name">Type: </div>
                        <div class="col-md-7 value">#prc.vacation.getType().getName()# Leave</div>
                    </div>
                	<div class="row static-info">
                        <div class="col-md-5 name">From-To: </div>
                        <div class="col-md-7 value">#DateFormat(prc.vacation.getFromDate(), 'mm/dd/yyyy')# - #DateFormat(prc.vacation.getToDate(), 'mm/dd/yyyy')#</div>
                    </div>
                	<div class="row static-info">
                        <div class="col-md-5 name">Length: </div>
                        <div class="col-md-7 value">#prc.vacation.getLength()#</div>
                    </div>
                	<div class="row static-info">
                        <div class="col-md-5 name">Fill-in: </div>
                        <div class="col-md-7 value">#prc.vacation.getDeputy().getFirstName()#</div>
                    </div>
                	<div class="row static-info">
                        <div class="col-md-5 name">Status: </div>
                        <div class="col-md-7 value">
                        	<span class="label #prc.vacation.statusClass#"> #prc.vacation.getStatus().getName()# </span>
                        </div>
                    </div>
                	<div class="row static-info">
                        <div class="col-md-5 name">Description: </div>
                        <div class="col-md-7 value">#prc.vacation.getDescription()#</div>
                    </div>

                    <cfif prc.vacation.getRejectedMessage() NEQ "">
                        <div class="row static-info">
                            <div class="col-md-5 name">Rejected Message: </div>
                            <div class="col-md-7 value">#prc.vacation.getRejectedMessage()#</div>
                        </div>
                    </cfif>
                    
                    <cfif prc.isApprovable AND prc.rightsToApprove NEQ "">
                        <cfif prc.rightsToApprove EQ "Manager">
                            <div class="row static-info">
                                <cfif prc.isLead>
                                    #html.startForm(action = "Users.mailingPrepare", method = "POST")#
                                        #html.hiddenField(name = "objectAction", value = "#prc.rightsToApprove# Approved")#
                                        #html.hiddenField(name = "objectName", value = "Vacation")#
                                        #html.hiddenField(name = "vacationId", value = "#prc.vacation.getId()#")#
                                    
                                        #html.submitButton(
                                            class = "col-md-2 col-md-offset-3 btn btn-lg green", 
                                            value = "Approve"
                                        )#
                                    
                                    #html.endForm()#
                                </cfif>
                                #includeLink(
                                    href = 'Users.writeRejectedMessage.#prc.vacation.getId()#?rejectedBy=#prc.rightsToApprove#',
                                    title = "Reject",
                                    name = "Reject",
                                    isModal = 1,
                                    btnClass = "col-md-2 col-md-offset-1 btn btn-lg red"
                                )#
                            </div>
                        <cfelse>
                            <div class="row static-info">
                                #html.startForm(action = "Users.mailingPrepare", method = "POST")#
                                    #html.hiddenField(name = "objectAction", value = "#prc.rightsToApprove# Approved")#
                                    #html.hiddenField(name = "objectName", value = "Vacation")#
                                    #html.hiddenField(name = "vacationId", value = "#prc.vacation.getId()#")#
                                
                                    #html.submitButton(
                                        class = "col-md-2 col-md-offset-3 btn btn-lg green", 
                                        value = "Approve"
                                    )#
                                
                                #html.endForm()#
                                #includeLink(
                                    href = 'Users.writeRejectedMessage.#prc.vacation.getId()#?rejectedBy=#prc.rightsToApprove#',
                                    title = "Reject",
                                    name = "Reject",
                                    isModal = 1,
                                    btnClass = "col-md-2 col-md-offset-1 btn btn-lg red"
                                )#
                            </div>
                        </cfif>
                    </cfif>
                </div>
            </div>
		</div>
	</div>
</cfoutput>
