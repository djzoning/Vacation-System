component persistent="true" table="LogAction" extends="Log" joincolumn="id"{
	property name="objectName" ormType="text";
	property name="objectId" ormType="integer";
	property name="objectAction" ormType="text";

	// Constructor
	function init(){
		super.init(useQueryCaching="false");
		return this;
	}

	function getTeamActions(teamId, filter = 0) {
		var criteria = this.newCriteria();
		var actions = criteria
			.createAlias('user', 'user')
			.createAlias('user.team', 'team')
			.eq('team.id', JavaCast('int', teamId))
			.list(
				sortOrder = 'timeStamp desc',
				max = javaCast('int', filter)
			);
		
		return actions;
	}

	function getUserActions(userId, filter = 0) {
		var criteria = this.newCriteria();
		var actions = criteria
			.createAlias('user', 'user')
			.eq('user.id', javaCast('int', userId))
			.list(
				sortOrder = 'timeStamp desc',
				max = javaCast('int', filter)
			);
		
		return actions;
	}

	function getByObjectIdAndUserId(objectId, userId) {
		var criteria = this.newCriteria();
		
		var actions = criteria
			.createAlias('user', 'user')
			.and(
				criteria.restrictions.eq('objectId', objectId),
				criteria.restrictions.eq('user.id', javaCast("int",userId)),
				criteria.restrictions.eq('action', 'mailingPrepare')
			)
			.list(
				sortOrder = 'timeStamp desc'
			);
						
		return actions;
	}

	function getUserSpecialActions(userId, action) {
		var criteria = this.newCriteria();
		
		var actions = criteria
			.createAlias('user', 'user')
			.and(
				criteria.restrictions.eq('user.id', javaCast("int", userId)),
				criteria.restrictions.eq('action', action),
				criteria.restrictions.gt('timeStamp', dateAdd("m", -1, now())) // dani wanted this
			)
			.list();

		return actions;
	}
}