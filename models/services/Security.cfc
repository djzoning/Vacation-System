component {
	property name="user" inject="User";

	function login(username, password) {
		theUser = user.findByUsername(username);

		if(isNull(theUser)) {
			return false;
		}

		var salt = theUser.getSalt();
		var hashedPassword = Hash(password & salt, "SHA-512");

		if(hashedPassword == theUser.getPassword()) {
			this.setUserSession(theUser);
			return true;
		}

		return false;
	}

	function logout() {
		structDelete(SESSION, "user");
	}

	function userValidator(rules, controller) {
		var roles = listToArray(rules['roles']);
		var permissions = listToArray(rules['permissions']);
		var authUser = getUserSession();

		if(! isStruct(authUser)) {
			return false;
		}

		if(arrayLen(roles) EQ 0 AND arrayLen(permissions) EQ 0) {
			return true;
		}

		for(var i = 1; i <= len(roles); i++) {
			if( authUser['role'] == roles[i]) {
				return true;
			}
		}

		for(var i = 1; i <= len(permissions); i++) {
			if( authUser['permissions'].indexOf(permissions[i]) != -1) {
				return true;
			}
		}

		return false;
	}

	function getUserSession() {
		if(! structKeyExists(SESSION,"user")) {
			return false;
		}

		return SESSION.user;
	}

	function setUserSession(theUser) {
		SESSION.user = {
			'username' = theUser.getUsername(),
			'id' = theUser.getId(),
			'email' = theUser.getEmail(),
			'role' = theUser.getRole().getName(),
			'permissions' = ['authenticatedUser'],
			'team' = {
				'name' = theUser.getTeam().getName(),
				'id' = theUser.getTeam().getId()
			},
			'image' = theUser.getImage()
		};

		if(theUser.getTeam().getName() == 'IT Support') {
			arrayAppend(SESSION.user.permissions, 'IT');
		}
	}

	function resetPassword(email) {
		theUser = user.findByEmail(email);
		
		if(isNull(theUser)) {
			return false;
		}

		var salt = theUser.getSalt();
		var newPasswordPlain = GenerateSecretKey("AES");
		var newHashedPassword = Hash(newPasswordPlain & salt, "SHA-512");
		
		theUser.setPassword(newHashedPassword);
		isUpdated = user.save(theUser);

		if(isUpdated) {
			mailService = new Mail(
				to = theUser.getEmail(),
				from = 'admin@44km.com',
				subject = 'Vacation.44km.com Password Reset',
				body = 'Hello, ' & theUser.getFirstName() & ', your new password for vacation.44km.com is <strong>' & newPasswordPlain & '</strong>',
				type = "html"
			);

			mailService.send();
		}

		return isUpdated;
	}
}