var UserValidator = (function() {

	var url = {
		email: "Users/checkEmail"
	}

	function validate() {
		validateEmail();
	}

	function validateEmail() {
		$('[name="email"]').change(function() {
			$this = $(this);
			checkEmail($this.val());
		});
	}

	function lockForm() {
		$('.edit-user [type="submit"]').attr('disabled', 'disabled');
	}

	function unlockForm() {
		$('.edit-user [type="submit"]').removeAttr('disabled');
	}

	function checkEmail(email) {
		$.get(
			url.email,
			{email: email},
			function(data) {
				var result = JSON.parse(data);
				if (!result) {
					showAlert("This email exists, try another email.", "warning", "emailAlert", 0);
					lockForm();
				} else {
					$('#responsive #alerts-container').empty();
					unlockForm();
				}
			}
		);
	}

	return {
		validate: validate
	}
})();
