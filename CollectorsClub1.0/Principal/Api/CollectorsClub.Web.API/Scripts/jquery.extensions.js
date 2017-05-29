define(['jquery'], function (jQuery) {
	jQuery.widget("ui.dialog", jQuery.ui.dialog, {
		/*! jQuery UI - v1.10.2 - 2013-12-12
		 *  http://bugs.jqueryui.com/ticket/9087#comment:27 - bugfix
		 *  http://bugs.jqueryui.com/ticket/4727#comment:23 - bugfix
		 *  allowInteraction fix to accommodate windowed editors
		 */
		_allowInteraction: function (event) {
			if (this._super(event)) {
				return true;
			}

			// address interaction issues with general iframes with the dialog
			if (event.target.ownerDocument != this.document[0]) {
				return true;
			}

			// address interaction issues with dialog window
			if ($(event.target).closest(".cke_dialog").length) {
				return true;
			}

			// address interaction issues with iframe based drop downs in IE
			if ($(event.target).closest(".cke").length) {
				return true;
			}
		},
		/*! jQuery UI - v1.10.2 - 2013-10-28
		 *  http://dev.ckeditor.com/ticket/10269 - bugfix
		 *  moveToTop fix to accommodate windowed editors
		 */
		_moveToTop: function (event, silent) {
			if (!event || !this.options.modal) {
				this._super(event, silent);
			}
		}
	});

	// función para poder indicar !important por jquery. Lo necesito por ahora en DNN5
	(function ($) {
		if ($.fn.style) {
			return;
		}

		// Escape regex chars with \
		var escape = function (text) {
			return text.replace(/[-[\]{}()*+?.,\\^$|#\s]/g, "\\$&");
		};

		// For those who need them (< IE 9), add support for CSS functions
		var isStyleFuncSupported = !!CSSStyleDeclaration.prototype.getPropertyValue;
		if (!isStyleFuncSupported) {
			CSSStyleDeclaration.prototype.getPropertyValue = function (a) {
				return this.getAttribute(a);
			};
			CSSStyleDeclaration.prototype.setProperty = function (styleName, value, priority) {
				this.setAttribute(styleName, value);
				var priority = typeof priority != 'undefined' ? priority : '';
				if (priority != '') {
					// Add priority manually
					var rule = new RegExp(escape(styleName) + '\\s*:\\s*' + escape(value) +
							'(\\s*;)?', 'gmi');
					this.cssText =
							this.cssText.replace(rule, styleName + ': ' + value + ' !' + priority + ';');
				}
			};
			CSSStyleDeclaration.prototype.removeProperty = function (a) {
				return this.removeAttribute(a);
			};
			CSSStyleDeclaration.prototype.getPropertyPriority = function (styleName) {
				var rule = new RegExp(escape(styleName) + '\\s*:\\s*[^\\s]*\\s*!important(\\s*;)?',
						'gmi');
				return rule.test(this.cssText) ? 'important' : '';
			}
		}

		// The style function
		$.fn.style = function (styleName, value, priority) {
			// DOM node
			var node = this.get(0);
			// Ensure we have a DOM node
			if (typeof node == 'undefined') {
				return this;
			}
			// CSSStyleDeclaration
			var style = this.get(0).style;
			// Getter/Setter
			if (typeof styleName != 'undefined') {
				if (typeof value != 'undefined') {
					// Set style property
					priority = typeof priority != 'undefined' ? priority : '';
					style.setProperty(styleName, value, priority);
					return this;
				} else {
					// Get style property
					return style.getPropertyValue(styleName);
				}
			} else {
				// Get CSSStyleDeclaration
				return style;
			}
		};
	})(jQuery);
});