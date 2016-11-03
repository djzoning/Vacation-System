<cfoutput>
	<div class="portlet-container" data-spy="affix" data-offset-top="180">
		<div class="portlet box blue filter">
			<div class="portlet-title">
				<div class="caption">
					<i class="fa fa-filter"></i>Filter
				</div>
			</div>
			<div class="filter-wrapper">
				<div>
					<div class="collapse-types" data-collapsed="false">Types</div>
					<cfloop array="#args.types#" index="type">
						<div class="checkbox types">
							<label>
								<input class="checkbox" type="checkbox" name="type" value="#type.getName()#" data-criteria="type">#type.getName()#
							</label>
						</div>
					</cfloop>
				</div>
				<div>
					<div class="collapse-statuses" data-collapsed="false">Statuses</div>
					<cfloop array="#args.statuses#" index="status">
						<div class="checkbox statuses">
							<label>
								<input class="checkbox" type="checkbox" name="status" value="#status#" data-criteria="status">#status#
							</label>
						</div>
					</cfloop>
				</div>
				<div>
					<div class="collapse-teams" data-collapsed="false">Teams</div>
					<cfloop array="#args.teams#" index="team">
						<div class="checkbox teams">
							<label>
								<input class="checkbox" type="checkbox" name="team" value="#team.getName()#" data-criteria="team">#team.getName()#
							</label>
						</div>
					</cfloop>
				</div>
			</div>
		</div>
		<div class="portlet box blue fetch-all">
			<div class="portlet-title">
				<div class="caption">
					<i class="fa fa-download"></i>Fetch All
				</div>
			</div>
		</div>
	</div>
</cfoutput>
