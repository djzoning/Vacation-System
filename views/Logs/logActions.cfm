<cfoutput>
	<div class="portlet box blue">
		<div class="portlet-title">
            <div class="caption">
                <i class="fa fa-globe"></i>
                <span class="caption-subject font-white sbold">Logs</span>
            </div>
            <div class="tools">
                <a href="javascript:;" class="reload"> </a>
                <a href="javascript:;" class="collapse"> </a>
            </div>
        </div>
        <div class="portlet-body">
        	<form class="container-fluid form-inline" style="margin-bottom: 15px;" action="/logs/logActions">
				<label for="">Object:</label>
				<select class="form-control" name="objectName" id="">
					<option value="">All</option>
					<cfloop list="#getSetting("RegisteredHandlers")#" index="handler">
						<option value="#handler#">#handler#</option>
					</cfloop>	
				</select>
			
				<label for="">Id:</label>
				<input class="form-control" type="text" name="objectId" value="">

				<button class="btn btn-submit btn-primary">Filter</button>		
			</form>

			<div class="table-responsive container-fluid">
				<table class="table table-striped table-bordered table-hover">
					<thead>
						<tr>
							<th></th>
							<th>Id</th>
							<th>BaseUrl</th>
							<th>Handler</th>
							<th>Action</th>
							<th>HttpMethod</th>
							<th>TimeStamp</th>
							<th>User</th>
							<th>Rc</th>			
						</tr>
					</thead>
					<tbody>
						<cfloop array="#prc.logs#" index="log">
							<cfset class="">
							<cfif log.getEntityName() EQ "LogError">
								<cfset class="danger">
							</cfif>

							<tr class="#class#">
								<td><a href="/logs/view/#log.getId()#" title="View" rel="tooltip"><i class="glyphicon glyphicon-zoom-in"></i></a></td>
								<td>#log.getId()#</td>
								<td>#log.getHtmlBaseUrl()#</td>
								<td>#log.getHandler()#</td>
								<td>#log.getAction()#</td>
								<td>#log.getHttpMethod()#</td>
								<td>#dateTimeFormat(log.getTimeStamp(), 'dd-mm-yyyy HH:nn:ss')#</td>
								
								<cfif log.hasUser()>
									<td>#log.getUser().getFirstName()#</td>	
								<cfelse>
									<td>Guest</td>
								</cfif>
								
								<td>#Left(log.getRc(), 50)#...</td>
							</tr>
						</cfloop>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</cfoutput>