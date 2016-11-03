function Calendar(options) {
	options = options || {};
	if (!options.$element) {
		console.error('A jQuery object is required!');
		return false;
	}

	if (!options.vacations && !options.url) {
		console.error('Either vacations or url is required!');
		return false;
	}

	this.$element = options.$element;
	this.vacations = options.vacations;
	this.allVacations = options.vacations;
	this.url = options.url;
	this.view = 'month';
	this.isLoaderSetup = false;

	return this;
}


Calendar.prototype.draw = function() {
	if (typeof this.url === 'string' && this.url.length) {
		var events = this.url;
	} else {
		var events = this.vacations;
	}

	var options = {
		header: {
			left: 'prev,next',
			center: 'title',
			right: 'year,month,prev,next'
		},
		firstDay: 1,
		businessHours: true,
		events: events,
		eventClick: this.eventClick
	};

	this.$element.fullCalendar(options);
	this.setupView();
	this.setupLoader();
	this.setupFilter();
	this.setupFetch();
	this.setHeight();
	setupFilterWidth();
}

Calendar.prototype.eventClick = function(calEvent, jsEvent, view) {
	var url = 'Vacations/view/' + calEvent.id;
	window.open(url, '_blank');
}

Calendar.prototype.setHeight = function() {
	var height = $(window).height() - this.$element.offset().top - $('.page-top').height();
	this.$element.fullCalendar('option', 'height', height);
	var _this = this;
	$(window).resize(function() {
		var height = $(window).height() - _this.$element.offset().top - $('.page-top').height();
		_this.$element.fullCalendar('option', 'height', height);
	});
}

function setupFilterWidth() {
	$('.filter').width($('.filter-container').width());
	$(window).resize(function() {
		$('.filter').width($('.filter-container').width());
	});
}

function resetFilter() {
	$filterControls = $('input.checkbox');
	$filterControls.iCheck('uncheck');
}

Calendar.prototype.setupFetch = function() {
	var _this = this;
	$('.fetch-all').click(function() {
		loaderStart();
		$.get(
			'calendar/get',
			function(data) {
				var events = JSON.parse(data);
				_this.$element.fullCalendar('removeEventSource', _this.vacations);
				_this.allVacations = _this.vacations = events;
				_this.$element.fullCalendar('addEventSource', _this.vacations);
				resetFilter();
				loaderStop();
			}
		)
	});
}

Calendar.prototype.setupLoader = function() {
	var $loader = $('.loader.loader-absolute');
	var left = this.$element.width() / 2 + $loader.width() * 2;
	var top = $(window).height() / 2 - $loader.height() * 4;
	$loader.css('left', left);
	$loader.css('top', top);
	var _this = this;
	if (!this.isLoaderSetup) {
		$(window).resize(function() {
			_this.setupLoader();
		});
		var $overlay = $('<div class="overlay"></div>');
		$overlay.css({
			position:'absolute',
			width: '100%',
			height: '100%',
			backgroundColor: 'rgba(100,100,100,0.3)',
			display: 'none',
			zIndex: '500',
			boxShadow: '0 0 80px 0 #aaa'
		});
		$('.fc-view-container').prepend($overlay);
	}
	
	this.isLoaderSetup = true;
}

Calendar.prototype.setupView = function() {
	var _this = this;
	$('.fc-year-button').click(function() {
		_this.view = 'year';
	});
	$('.fc-month-button').click(function() {
		_this.view = 'month';
	});
}

function loaderStart() {
	$('.loader').show();
	$('.overlay').show();
}

function loaderStop() {
	$('.loader').hide();
	$('.overlay').hide();
}

Calendar.prototype.setupFilter = function() {
	var _this = this;
	setupCollapsableFilter();
	$filterControls = $('input.checkbox');
	$filterControls.iCheck({
	    checkboxClass: 'icheckbox_polaris',
	    radioClass: 'iradio_polaris',
	    increaseArea: '-10%'
	});
	$filterControls.on('ifChanged', function() {
		if (_this.view == 'year') {
			loaderStart();
		}
		
		setTimeout(function(){
			var filter = [];
			$('.filter input:checked').each(function() {
				var $this = $(this);
				var criteria = $this.data('criteria');
				var obj = {
					criteria: criteria,
					value: $this.val()
				};
				filter.push(obj);
			});
			if (!filter.length) {

				_this.$element.fullCalendar('removeEventSource', _this.vacations);
				_this.vacations = _this.allVacations;
				_this.$element.fullCalendar('addEventSource', _this.vacations);
			} else {
				_this.filter(filter);
			}

			loaderStop();
		}, 1)
	});
}

Calendar.prototype.filter = function(filter) {
	this.$element.fullCalendar('removeEventSource', this.vacations);
	this.$element.fullCalendar('addEventSource', this.allVacations);
	this.vacations = this.$element.fullCalendar('clientEvents', function(vacation) {		
		return evalFilter(filter, 'type', vacation.type.name) && evalFilter(filter, 'status', vacation.status.name) && evalFilter(filter, 'team', vacation.team.name);
	});

	this.$element.fullCalendar('removeEventSource', this.allVacations);
	this.$element.fullCalendar('addEventSource', this.vacations);
}

function setupCollapsableFilter() {
	$('.collapse-types').click(function(){
		collapse.call(this, 'types');
	});
	$('.collapse-statuses').click(function(){
		collapse.call(this, 'statuses');
	});
	$('.collapse-teams').click(function(){
		collapse.call(this, 'teams');
	});
}

function collapse(className) {
	var $this = $(this);
	if ($this.attr('data-collapsed') == 'true') {
		$('.' + className).show(300);
		$this.attr('data-collapsed', 'false');
	} else {
		$('.' + className).hide(300);
		$this.attr('data-collapsed', 'true');
	}
}

function evalFilter(filter, criteria, value) {
	var result = [];
	for(var i in filter) {
		if (filter[i].criteria === criteria) {
			result.push(filter[i].value);
		}
	}

	if (!result.length) {
		return true;
	}

	return result.includes(value);
}
