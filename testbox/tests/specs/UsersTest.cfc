component extends="testbox.system.BaseSpec"{

/*********************************** LIFE CYCLE Methods ***********************************/

	// executes before all suites+specs in the run() method
	function beforeAll(){
	}

	// executes after all suites+specs in the run() method
	function afterAll(){
	}

/*********************************** BDD SUITES ***********************************/

	function run(){
		// The following should NOT fail
		describe("Users controller testing", function(){
		    beforeEach(function() {
		        users = new handlers.Users();
		        authentication = new models.services.Authentication();
		    });

			it("Checking log in user function", function(){
				event = StructNew();
				rc = StructNew();
				prc = StructNew();

				rc.username = "lubo";
				rc.password = "citi";

				var USERS = getMockBox().createMock('handlers.Users');
				var mockAuthentication = getMockBox().createMock('models.services.Authentication');

				var mockUserModel = getMockBox().createMock('models.User');

				// var mockMessageBox = getMockBox().createMock('messagebox@cbmessagebox');
				var mockMessageBox = getMockBox().createMock('modules.cbmessagebox.models.MessageBox');
				
				// dump(mockMessageBox); abort;
				var flash = {
					name 		= 'pesho',
					value 		= 'lqlq',
					inflateToRC = false,
					saveNow		= true,
					autoPurge	= false
				};

				mockMessageBox.$('put', flash);
				mockMessageBox.$property(propertyName = "flash", mock = mockMessageBox);
				mockMessageBox.$property(propertyName = "flashKey", mock = mockUserModel);

				// var modelUserResult = getMockBox().createMock();
				mockUserModel.setSalt('5C4106CB3CD1A00D0AF086CA1632E4043D8BA596FB973105E26D69DEF0F8E55FCB0EDB9F68E88FF7206DA7AFA9A16633E8B873694C3B39B05B00ADDEADFADA50');
				// dump(mockUserModel.getSalt());abort;
				mockUserModel.$('findByUsername', mockUserModel);

				mockAuthentication.$property(propertyName = "user", mock = mockUserModel);

				USERS.$property(propertyName = "messageBox", mock = mockMessageBox);
				USERS.$property(propertyName = "UserModel", mock = mockUserModel);
				USERS.$property(propertyName = "Authentication", mock = mockAuthentication);

				var event = USERS.loginUser(event, rc, prc);
				dump('result');
				dump(event);
				abort;
			});
		});
	}

}