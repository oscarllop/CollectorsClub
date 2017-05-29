/*! angular-csv-import - v0.0.26 - 2015-11-11
* Copyright (c) 2015 ; Licensed  */
'use strict';

var csvImport = angular.module('ngCsvImport', []);

csvImport.directive('ngCsvImport', function () {
    return {
        restrict: 'E',
        transclude: true,
        replace: true,
        scope: {
            content: '=?',
            header: '=?',
            headerVisible: '=?',
            separator: '=?',
            separatorVisible: '=?',
            result: '=?',
            encoding: '=?',
            encodingVisible: '=?',
            accept: '=?'
        },
        template: '<div>' +
		  '<div ng-show="headerVisible"><div class="label">Header</div><input type="checkbox" ng-model="header"></div>' +
			'<div ng-show="encoding && encodingVisible"><div class="label">Encoding</div><span>{{encoding}}</span></div>' +
			'<div ng-show="separator && separatorVisible">' +
			'<div class="label">Seperator</div>' +
			'<span><input class="separator-input" type="text" ng-change="changeSeparator" ng-model="separator"><span>' +
			'</div>' +
			'<div><span class="ms-btn ms-btn-primary" style="position:relative;margin-left: 13px;">Choose File...<input type="file" style="position:absolute;z-index:2;top:0;left:0;opacity:0;background-color:transparent;color:transparent;filter: alpha(opacity=0);-ms-filter:&quot;progid:DXImageTransform.Microsoft.Alpha(Opacity=0)&quot;;" accept="{{accept}}" /></span></div>' +
			'</div>',
        link: function (scope, element) {
            scope.separatorVisible = scope.separatorVisible || false;
            scope.headerVisible = scope.headerVisible || false;

            angular.element(element[0].querySelector('.separator-input')).on('keyup', function (e) {
                if (scope.content != null) {
                    var content = {
                        csv: scope.content,
                        header: scope.header,
                        separator: e.target.value,
                        encoding: scope.encoding
                    };
                    scope.result = csvToJSON(content);
                    scope.$apply();
                }
            });

            element.on('change', function (onChangeEvent) {
                var reader = new FileReader();
                var validFile = true;
                if (scope.accept != "=?" && scope.accept != "" && '.' + onChangeEvent.target.files[0].name.split('.')[onChangeEvent.target.files[0].name.split('.').length - 1].toLowerCase() != scope.accept) {
                    validFile = false;
                    alert('Please upload only CSV file.');
                }
                if (validFile) {
                    scope.filename = onChangeEvent.target.files[0].name;
                    reader.onload = function (onLoadEvent) {
                        scope.$apply(function () {
                            var content = {
                                csv: onLoadEvent.target.result.replace(/\r\n|\r/g, '\n'),
                                header: scope.header,
                                separator: scope.separator
                            };
                            scope.content = content.csv;
                            scope.result = csvToJSON(content);
                            scope.result.filename = scope.filename;
                        });
                    };

                    if ((onChangeEvent.target.type === "file") && (onChangeEvent.target.files != null || onChangeEvent.srcElement.files != null)) {
                        reader.readAsText((onChangeEvent.srcElement || onChangeEvent.target).files[0], scope.encoding);
                    } else {
                        if (scope.content != null) {
                            var content = {
                                csv: scope.content,
                                header: !scope.header,
                                separator: scope.separator
                            };
                            scope.result = csvToJSON(content);
                        }
                    }
                }
            });

            var csvToJSON = function (content) {
                var lines = content.csv.split('\n');
                var result = [];
                var start = 0;
                var columnCount = lines[0].split(content.separator).length;

                var headers = [];
                if (content.header) {
                    headers = lines[0].split(content.separator);
                    start = 1;
                }

                for (var i = start; i < lines.length; i++) {
                    var obj = {};
                    var currentline = lines[i].split(new RegExp(content.separator + '(?![^"]*"(?:(?:[^"]*"){2})*[^"]*$)'));
                    if (currentline.length === columnCount) {
                        if (content.header) {
                            for (var j = 0; j < headers.length; j++) {
                                obj[headers[j]] = currentline[j];
                            }
                        } else {
                            for (var k = 0; k < currentline.length; k++) {
                                obj[k] = currentline[k];
                            }
                        }
                        result.push(obj);
                    }
                }
                return result;
            };
        }
    };
});